//
//  VSLogModule.m
//  chartTest
//
//  Created by kane.etek on 2019/3/21.
//  Copyright © 2019 lihaiyang. All rights reserved.
//

#import "VSLogModule.h"
#import <UIKit/UIKit.h>
#import <SSZipArchive/SSZipArchive.h>
#import <YYModel/YYModel.h>
#include <libkern/OSAtomic.h>
#include <execinfo.h>

#define kMaxBufferSize (10*1024)
#define kMaxBufferNum (3)
#define kFileMaxSize (10 * 1024 * 1024)
#define kFileMaxCount (1)
// 日志文件前缀
#define kVSLogFilePrefile @"log_n_"

@interface VSLogModule () {
    // 打印到console的级别
    VSLogLevel _consoleLevel;
    // 写入文件的log级别
    VSLogLevel _fileLogLevel;
    
    NSString *_logRootPath;
    // weak，只是指向buffer1或者buffer2
    NSInteger _curIndex;
    
    // 使用双buffer防止log数据丢失，和mutable多线程同时改变引起的闪退
    NSArray<NSMutableData *> *_bufferArr;
    
    __weak NSMutableData *_logCurBuffer;
}

@end

@implementation VSLogModule

#pragma mark - Lifecycle (dealloc init viewDidLoad memoryWarning...)

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)shareInstance{
    static VSLogModule *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VSLogModule alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _consoleLevel = VSLogLevelInfo;
        _fileLogLevel = VSLogLevelInfo;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:kMaxBufferNum];
        for (int i=0; i<kMaxBufferNum; ++i) {
            [arr addObject:[NSMutableData dataWithCapacity:kMaxBufferSize]];
        }
        _bufferArr = arr;
        _curIndex = 0;
        _logCurBuffer = _bufferArr[_curIndex];
        _logRootPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/VSLog"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:_logRootPath isDirectory:NULL]) {
            [fileManager createDirectoryAtPath:_logRootPath
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:NULL];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(teWriteAllBuffer2File) name:UIApplicationWillTerminateNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bgWriteAllBuffer2File) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
    }
    return self;
}

#pragma mark - modEvent/modNotice
- (void)teWriteAllBuffer2File {
    [self writeAllBuffer2FileWithTag:@"[app]WillTerminate"];
}

- (void)bgWriteAllBuffer2File
{
    [self writeAllBuffer2FileWithTag:@"[app]DidEnterBackground"];
}

- (void)writeAllBuffer2FileWithTag:(NSString*)tagStr
{
    [self vs_level:VSLogLevelInfo log:tagStr];
    [self writeBuffer2File:0];
}



#pragma mark - Public

+ (void)initLogLevel:(VSLogLevel)level
{
    VSLogModule *log = [self shareInstance];
    log->_consoleLevel = level;
}

+ (void)vs_level:(VSLogLevel)level log:(NSString *)format, ...
{
    NSString *outString = nil;
    if (format) {
        va_list argList;
        va_start(argList, format);
        outString = [[NSString alloc] initWithFormat:format arguments:argList];
        va_end(argList);
    }
    
    [[VSLogModule shareInstance] vs_level:level log:outString];
}

+ (void)vs_level:(VSLogLevel)level logStr:(NSString *)logStr
{
    [[VSLogModule shareInstance] vs_level:level log:logStr];
}

+ (NSData *)vs_fileLogData
{
    return [[VSLogModule shareInstance] allFileLogData];
}

+ (void)vs_writeCustomFile:(NSString *)fileFullPath text:(NSString *)format, ...
{
    
}

+ (void)vs_writeCustomFile:(NSString *)fileFullPath data:(NSData *)data
{
    
}

#pragma mark - Event Respone

#pragma mark - Delegate

#pragma mark - Private

#pragma mark mutli files

- (NSArray<NSString *> *)fetchAllLogFileNames
{
    NSDirectoryEnumerator<NSString *> *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:_logRootPath];
    NSArray<NSString *> *allFileArr = [enumerator.allObjects sortedArrayUsingComparator:^NSComparisonResult(NSString *  _Nonnull obj1, NSString *  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    return allFileArr;
}

- (NSString *)fetchCurrentFileName
{
    NSString *logPath = _logRootPath;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *currLogFilePath = nil;
    
    NSArray<NSString *> *allFileArr = [self fetchAllLogFileNames];
    BOOL isNeedCreateNewLogFile = YES;
    long fileIndex = 0;
    NSInteger maxFileNum = kFileMaxCount;
    if (allFileArr.count > 0) {
        NSString *lastFileName = allFileArr.lastObject;
        NSString *lastLogPath = [logPath stringByAppendingPathComponent:lastFileName];
        if ([self fetchFileSize:lastLogPath] < kFileMaxSize) {
            isNeedCreateNewLogFile = NO;
            currLogFilePath = lastLogPath;
        } else {
            NSArray *comArr = [lastFileName componentsSeparatedByString:@"_"];
            if (comArr.count == 4) {
                fileIndex = [comArr[2] integerValue] + 1;
            }
        }
    }
    
    if (isNeedCreateNewLogFile) {
        long timestamp = [[NSDate date] timeIntervalSince1970];
        NSString *filePath = [logPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%03ld_%ld.txt", kVSLogFilePrefile, fileIndex, timestamp]];
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        NSLog(@"create file:%@", filePath.lastPathComponent);
        currLogFilePath = filePath;
        --maxFileNum;
    }
    
    if (allFileArr.count > maxFileNum) {
        // 删除多余的文件
        NSInteger deleteCount = allFileArr.count - maxFileNum;
        for (NSInteger i=0; i<deleteCount; ++i) {
            NSString *filePath = [logPath stringByAppendingPathComponent:allFileArr[i]];
            NSLog(@"delete file:%@", filePath.lastPathComponent);
            [fileManager removeItemAtPath:filePath error:nil];
        }
    }
    
    return currLogFilePath;
}

- (NSData *)allFileLogData
{
    [self writeAllBuffer2FileWithTag:@"[App]PackageLogFile"];
    // IDO手环Log信息拷贝到压缩路径
    NSString *idoLogPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/IDOLog"];
    NSString *toPath = [_logRootPath stringByAppendingString:@"/IDOLog"];
    if ([[NSFileManager defaultManager] isExecutableFileAtPath:idoLogPath]) {
        [[NSFileManager defaultManager] copyItemAtPath:idoLogPath toPath:toPath error:nil];
    }
    // Log文件压缩
    NSString *zipPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/VSLog.zip"];
    [SSZipArchive createZipFileAtPath:zipPath withContentsOfDirectory:_logRootPath];
    NSData *logData = [NSData dataWithContentsOfFile:zipPath];
    [[NSFileManager defaultManager] removeItemAtPath:zipPath error:nil];
    // 移除IDO手环Log文件
    [[NSFileManager defaultManager] removeItemAtPath:toPath error:nil];
    return logData;
}

- (long long)fetchFileSize:(NSString *)filePath
{
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
    long long fileSize = [fileSizeNumber longLongValue];
    
    return fileSize;
}

#pragma mark buffer

- (void)clearLogBuffer:(NSMutableData *)buffer
{
    [buffer resetBytesInRange:NSMakeRange(0, buffer.length)];
    buffer.length = 0;
}

- (void)writeContect2File:(NSString *)contect
{
    [_logCurBuffer appendData:[contect dataUsingEncoding:NSUTF8StringEncoding]];
    [self writeBuffer2File:kMaxBufferSize];
}

- (void)writeBuffer2File:(NSInteger)maxSize
{
    if (_logCurBuffer.length > maxSize) {
        NSFileHandle *writeHandle = [NSFileHandle fileHandleForWritingAtPath:[self fetchCurrentFileName]];
        [writeHandle seekToEndOfFile];
        
        // 切换buffer
        _curIndex = (_curIndex + 1) % kMaxBufferNum;
        _logCurBuffer = _bufferArr[_curIndex];
        
        for (int i=0; i<kMaxBufferNum; ++i) {
            if (i != _curIndex) {
                NSMutableData *buffer = _bufferArr[i];
                if (buffer.length > 0) {
                    [writeHandle writeData:buffer];
                    [self clearLogBuffer:buffer];
                }
            }
        }
    }
}

#pragma mark format string

- (NSString *)tagFromLevel:(VSLogLevel)level
{
    NSArray<NSString *> *tagArr = @[@"<Error>:",
                                    @"<Warning>:",
                                    @"<Info>:",
                                    @"<Debug>:",
                                    @"<Verbose>:"];
    NSString *tag = @"<Unknow>:";
    if (level < tagArr.count) {
        tag = tagArr[level];
    }
    
    return tag;
}

-(NSString *)formattedDate:(NSDate *)date withFormat:(NSString *)format{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });
    
    [formatter setDateFormat:format];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setLocale:[NSLocale autoupdatingCurrentLocale]];
    return [formatter stringFromDate:date];
}

- (NSString *)formatString:(NSString *)format, ...
{
    NSString *outString = nil;
    if (format) {
        va_list argList;
        va_start(argList, format);
        outString = [[NSString alloc] initWithFormat:format arguments:argList];
        va_end(argList);
    }
    return outString;
}

- (void)vs_level:(VSLogLevel)level log:(NSString *)log
{
    NSString *tagStr = [self tagFromLevel:level];
    if (log.length > 0) {
        if (level <= _consoleLevel) {
            NSLog(@"%@%@", tagStr, log);
        }
        
        if (level <= _fileLogLevel) {
            NSMutableString *logStr = [NSMutableString string];
            [logStr appendString:[self formattedDate:[NSDate date] withFormat:@"yyyy-MM-dd HH:mm:ss.SSS Z"]];
            [logStr appendFormat:@"%@%@", tagStr, log];
            [logStr appendString:@"\r\n"];
            [self writeContect2File:logStr];
        }
    }
}

#pragma mark -
void uncaughtExceptionHandler(NSException *exception) {
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    // 出现异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString *name = [exception name];
//    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@", reason, name, stackArray];
    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:stackArray];
    [tmpArr insertObject:name atIndex:0];
    [tmpArr insertObject:reason atIndex:0];
    VSError(@"%@",[tmpArr yy_modelDescription]);
    //保存到本地
//    [exceptionInfo writeToFile:[NSString stringWithFormat:@"%@/Documents/error.log",NSHomeDirectory()]  atomically:YES encoding:NSUTF8StringEncoding error:nil];
    //立即写入文件
    [[VSLogModule shareInstance] writeAllBuffer2FileWithTag:@"[app]DidException"];
}

#pragma mark -
- (void)registerExceptionSignal {
{
    //信号量截断
    signal(SIGHUP,SignalExceptionHandler); //程序终端中止信号
    signal(SIGINT,SignalExceptionHandler); //程序键盘中断信号
    signal(SIGQUIT,SignalExceptionHandler);
    signal(SIGABRT,SignalExceptionHandler); //程序中止命令中止信号
    signal(SIGILL,SignalExceptionHandler);  //程序非法指令信号
    signal(SIGSEGV,SignalExceptionHandler); //程序无效内存中止信号
    signal(SIGFPE,SignalExceptionHandler); //程序浮点异常信号
    signal(SIGBUS,SignalExceptionHandler); //程序内存字节末对齐中止信号
    signal(SIGPIPE,SignalExceptionHandler);} //程序Socket发送失败中止信号
}

void SignalExceptionHandler(int signal)
{
    //系统异常捕获 注意debug状态 系统debug会优先拦截
    NSMutableString *mstr = [[NSMutableString alloc] init];
    [mstr appendString:@"Stack:\n"];
    void* callstack[128];
    int i, frames = backtrace(callstack, 128);
    char** strs = backtrace_symbols(callstack, frames);
    for (i = 0; i <frames; ++i) {
        [mstr appendFormat:@"%s\n", strs[i]];
    }
    VSError(@"%@",mstr);
}

+(NSString *)vs_formattedDate{
    return [[VSLogModule shareInstance] formattedDate:[NSDate date] withFormat:@"yyyy-MM-dd HH:mm:ss.SSS Z"];
}


#pragma mark - Getters and Setters

#pragma mark - Supperclass

#pragma mark - NSObject

@end
