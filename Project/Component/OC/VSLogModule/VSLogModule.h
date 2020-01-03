//
//  VSLogModule.h
//  chartTest
//
//  Created by kane.etek on 2019/3/21.
//  Copyright © 2019 lihaiyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  log级别
 *  Info之前(包含Info)会写入文件 文件路径路径为 Document/VSLog/log.dat
 */
typedef NS_ENUM(NSUInteger, VSLogLevel) {
    VSLogLevelError   = 1,
    VSLogLevelWarn    = 1,
    VSLogLevelInfo    = 2,
    VSLogLevelDebug   = 3,
    VSLogLevelVerbose = 4,
};

#define VSLogMacro(level, x, ...) [VSLogModule vs_level:level log:x, ## __VA_ARGS__]

#define VSError(x, ...)     VSLogMacro(VSLogLevelError,x, ##__VA_ARGS__)
#define VSWarn(x, ...)      VSLogMacro(VSLogLevelWarn,x, ##__VA_ARGS__)
#define VSLog(x, ...)      VSLogMacro(VSLogLevelInfo,x, ##__VA_ARGS__)
#define VSDebug(x, ...)     VSLogMacro(VSLogLevelDebug, (@"%s [Line %d]\r\n" x),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define VSLogVerbose(x, ...)   VSLogMacro(VSLogLevelVerbose,x, ##__VA_ARGS__)

void uncaughtExceptionHandler(NSException *exception);

@interface VSLogModule : NSObject

/**
 *  指定log级别和写入文件的路径
 *
 *  @param level   打印到console的级别，默认是VSLogLevelInfo
 */
+ (void)initLogLevel:(VSLogLevel)level;

/**
 *  打印日志
 *
 *  @param level  打印的等级
 *  @param format format
 */
+ (void)vs_level:(VSLogLevel)level log:(NSString *)format, ...;

/**
 *  打印日志 （给swift的接口）
 *
 *  @param level  打印的等级
 *  @param logStr 打印的字符串
 */
+ (void)vs_level:(VSLogLevel)level logStr:(NSString *)logStr;

/**
 *  获取到所有写入文件的记录 zip包
 *
 *  @return utf-8编码的data
 */
+ (NSData *)vs_fileLogData;


/**
 指定文件路径写数据
 
 @param fileFullPath 文件的完整路径
 @param format 需要写入的数据 字符串
 */
+ (void)vs_writeCustomFile:(NSString *)fileFullPath text:(NSString *)format, ...;
+ (void)vs_writeCustomFile:(NSString *)fileFullPath data:(NSData *)data;

/**
 *  根据时间格式输出时间戳
 *
 *  @return yyyy-MM-dd HH:mm:ss.SSSSS+Z格式的时间戳
 */
+(NSString *)vs_formattedDate;
@end

NS_ASSUME_NONNULL_END
