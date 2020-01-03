//
//  Date+Extension.swift
//  VeSync
//
//  Created by Sheldon on 2019/9/10.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

extension Date {
    // MARK: - 年
    var year: Int {
        return NSCalendar.current.component(.year, from: self)
    }
    // MARK: - 月
    var month: Int {
        return NSCalendar.current.component(.month, from: self)
    }
    // MARK: - 日
    var day: Int {
        return NSCalendar.current.component(.day, from: self)
    }
    // MARK: - 时
    var hour: Int {
        return NSCalendar.current.component(.hour, from: self)
    }
    // MARK: - 分
    var minute: Int {
        return NSCalendar.current.component(.minute, from: self)
    }
    
    // MARK: - 星期几
    func weekDay() -> Int {
        let interval = Int(self.timeIntervalSince1970)
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
    // MARK: - 当月天数
    func countOfDaysInMonth() -> Int {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
        return (range?.length)!
    }
    // MARK: - 当月第一天是星期几
    func firstWeekDay() -> Int {
        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let firstWeekDay = (calendar as NSCalendar?)?.ordinality(of: NSCalendar.Unit.weekday, in: NSCalendar.Unit.weekOfMonth, for: self)
        return firstWeekDay! - 1
        
    }
    // MARK: - 是否是今天
    func isToday() -> Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year, .month, .day], from: self)
        let comNow = calendar.dateComponents([.year, .month, .day], from: Date())
        return com.year == comNow.year && com.month == comNow.month && com.day == comNow.day
    }
    // MARK: - 是否是这个月
    func isThisMonth() -> Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year, .month, .day], from: self)
        let comNow = calendar.dateComponents([.year, .month, .day], from: Date())
        return com.year == comNow.year && com.month == comNow.month
    }
    // MARK: - 是否今年
    func isThisYear() -> Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year, .month, .day], from: self)
        let comNow = calendar.dateComponents([.year, .month, .day], from: Date())
        return com.year == comNow.year
    }
    // MARK: - 距离2018-01-01的日,周,月统计量
    func getCounts(type: Int) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let startDate = formatter.date(from: "2018-01-01")
        
        var count: Int = 0
        
        if type == 0 {    //日
            let comps = Calendar.current.dateComponents([.day], from: startDate!, to: self)
            count = comps.day!
        }
        
        if type == 1 {    //周
            let comps = Calendar.current.dateComponents([.day], from: startDate!, to: self)
            count = comps.day!/7
        }
        
        if type == 2 {    //月
            let comps = Calendar.current.dateComponents([.month], from: startDate!, to: self)
            count = comps.month!
        }
        return count
    }
    
    // 本周开始日期（星期天）
    func startOfThisWeek() -> Date {
        let calendar = NSCalendar.current
        let commponets = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        let startOfWeek = calendar.date(from: commponets)
        return startOfWeek!
    }
    
    // 本月开始日期
    func startOfCurrentMonth() -> Date {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        let startOfMonth = calendar.date(from: components)!
        return startOfMonth
    }
    
    /// 获取偏移月份的日期
    ///
    /// - Parameter offset: 偏移的月份
    func getDateFromCurrentMonth(offset: Int) -> Date? {
        let calendar = Calendar.current
        var coms = calendar.dateComponents([.year, .month, .day], from: self)
        coms.month = coms.month! - offset
        coms.day = 1
        return calendar.date(from: coms)
    }
    
    /// 获取这个月有多少天
    ///
    /// - Returns:
    func getMonthHowManyDay() -> Range<Int> {
        return Calendar.current.range(of: .day, in: .month, for: self)!
    }
    
    /// 获取这个月第一天的日期
    ///
    /// - Returns:
    func getMonthFirstDay() -> Date? {
        let calendar = Calendar.current
        var com = calendar.dateComponents([.year, .month, .day], from: self)
        com.day = 1
        return calendar.date(from: com)
    }
    
    /// 获取这个月最后一天的日期
    func getMonthEndDay(returnEndTime: Bool = false) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.month = 1
        components.second = -1
        components.timeZone = TimeZone.current
        let endOfMonth = calendar.date(byAdding: components, to: startOfCurrentMonth())!
        return endOfMonth
    }
    
    /// 获取偏移天数的日期
    ///
    /// - Parameter offset: 偏移天数
    /// - Returns:
    func getDay(offset: Int) -> Date? {
        let calendar = Calendar.current
        var com = calendar.dateComponents([.year, .month, .day], from: self)
        com.day = com.day! + offset
        return calendar.date(from: com)
    }
    
    func date2String() -> String? {
        let dateformatter = DateFormatter.init()
        dateformatter.dateFormat = "yyyy-MM-dd"
        return dateformatter.string(from: self)
    }
    
//    //该时间所在周的第一天日期（2017年12月17日 00:00:00）
//    var startOfWeek: Date {
//        let calendar = NSCalendar.current
//        let components = calendar.dateComponents(
//            Set<Calendar.Component>([.yearForWeekOfYear, .weekOfYear]), from: self)
//        let date = calendar.date(from: components)!
//        return date.getDay(offset: 1)!
//    }
//
//    //该时间所在周的最后一天日期（2017年12月23日 00:00:00）
//    var endOfWeek: Date {
//        let calendar = NSCalendar.current
//        var components = DateComponents()
//        components.day = 6
//        return calendar.date(byAdding: components, to: self.startOfWeek)!
//    }

    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 0, to: sunday)
    }

    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 6, to: sunday)
    }

    /// 月的第一天
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }

    /// 月的最后一天
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }

}

class DateClass {
    // MARK: - 当前年月日字符串
    static func todayString() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        return dateFormat.string(from: Date())
    }
    // MARK: - 当前年月日时分秒字符串
    static func todayIntegrateString() -> String {
        let dateFormat = DateFormatter()
        // 以中国为准
        let locale = Locale(identifier: "zh")
        dateFormat.locale = locale
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormat.string(from: Date())
    }
    // MARK: - 获取当前时间戳(秒)
    static func getNowTimeS() -> Int {
        let date = Date()
        let timeInterval: Int = Int(date.timeIntervalSince1970)
        return timeInterval
    }
    // MARK: - 获取当前时区的时间
    static func getCurrentTimeZone() -> Date {
        let date = Date()
        let zone = TimeZone.current
        let interval = zone.secondsFromGMT()
        let nowDate = date.addingTimeInterval(TimeInterval(interval))
        return nowDate
    }
    // MARK: - 获取0时区的开始时间（2018-5-13 16：00：00）
    static func getZeroTimeZone() -> Date {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let todayDate = dateFormat.date(from: DateClass.todayString())
        return todayDate!
    }
    // MARK: - 获取获取当前时区的开始时间（2018-5-13 00：00：00）
    static func getCurrentInitTimeZone() -> Date {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let zone = TimeZone.current
        dateFormat.timeZone = zone
        let interval = zone.secondsFromGMT()
        let todayDate = dateFormat.date(from: DateClass.todayString())
        return todayDate!.addingTimeInterval(TimeInterval(interval))
    }
    // MARK: - 将时间戳按指定格式时间输出 13569746264 -> 2018-05-06
    static func timestampToStr(_ timestamp: Int, formatStr: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let zone = TimeZone.current
        let dateFormat = DateFormatter()
//        // 以中国为准
//        let locale = Locale(identifier: "zh")
//        dateFormat.locale = locale
        dateFormat.dateFormat = formatStr
        dateFormat.timeZone = zone
        let str = dateFormat.string(from: date)
        return str
    }
    // MARK: - 将时间格式转换时间戳输出 2018-05-06 -> 13569746264
    static func timeStrToTimestamp(_ timeStr: String, formatStr: String) -> Int {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = formatStr
        let date = dateFormat.date(from: timeStr) ?? Date()
        let timestamp = Int(date.timeIntervalSince1970)
        return timestamp
    }
    // MARK: - 将制定格式时间转自定义格式时间 2018-05-06 -> 2018-05-06 00:00:00
    static func timeStrToTimeStr(_ timeStr: String, formatStr: String, toFormatStr: String) -> String {
        let timestamp = DateClass.timeStrToTimestamp(timeStr, formatStr: formatStr)
        return DateClass.timestampToStr(timestamp, formatStr: toFormatStr)
    }
    // MARK: - 获取当前时间按指定格式时间输出
    static func getCurrentTimeStr(formatStr: String) -> String {
        let date = Date()
        let zone = TimeZone.current
        let dateFormat = DateFormatter()
        // 以中国为准
        let locale = Locale(identifier: "zh")
        dateFormat.locale = locale
        dateFormat.dateFormat = formatStr
        dateFormat.timeZone = zone
        let str = dateFormat.string(from: date)
        return str
    }
    
    // MARK: - 距离指定日期偏移天数的日期
    static func dateStringOffset(from: String, offset: Int) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        guard let fromDate = dateFormat.date(from: from) else {
            return from
        }
        
        var cmps = Calendar.current.dateComponents([.year, .month, .day], from: fromDate)
        cmps.day = cmps.day! + offset
        let resultDate = Calendar.current.date(from: cmps)
        return dateFormat.string(from: resultDate!)
    }
    
    // MARK: - 将指定格式时间字符串转成Date
    static func getTimeStrToDate(formatStr: String, timeStr: String) -> Date {
        let zone = TimeZone.current
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = formatStr
        dateFormat.timeZone = zone
        return dateFormat.date(from: timeStr)!
    }
    
    static func getSpecialDays(dateStr: String, count: Int) -> [String] {
        var days = [String]()
        let dateformatter = DateFormatter.init()
        dateformatter.dateFormat = "yyyy-MM-dd"
        let date = dateformatter.date(from: dateStr)
        let calendar = Calendar.current
        
        for index in 0..<count {
            var dateComponents = calendar.dateComponents([.year, .month, .day], from: date!)
            dateComponents.day = dateComponents.day! + index
            let newDate = calendar.date(from: dateComponents)
            let dateString = dateformatter.string(from: newDate!)
            days.append(dateString)
        }
        return days
    }
    
    // MARK: - 根据时制转换将时间戳转成时分字符串 9:20 PM / 18:20
    static func timestampToHourMinStr(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let zone = TimeZone.current
        // 12/24时间制跟随系统显示
        let formatStr =  "hh:mm a"
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = formatStr
        dateFormat.timeZone = zone
        dateFormat.amSymbol = "AM"
        dateFormat.pmSymbol = "PM"
        let str = dateFormat.string(from: date)
        return str
    }
    
    // MARK: - 获取当前时制 false：12小时 true：24小时
    static func getCurrenDateMetric() -> Bool {
        let formatStringForHours = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: NSLocale.current)
        let containsA = formatStringForHours?.range(of: "a")
        let has24 = containsA != nil ? false : true
        return has24
    }
    
}
