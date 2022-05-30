import Foundation

extension Date {
    
    static func utcDate(fromString dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: dateString)
    }
    
    func toFormat(format: String) -> String? {
        
        let inputDF = DateFormatter()
        inputDF.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SZ"
        
        if let dateString = self.toString(),
            let date = inputDF.date(from: dateString) {
            let outputDF = DateFormatter()
            outputDF.dateFormat = format
            
            return outputDF.string(from: date)
        }
        
        return nil
    }
    
    static func from(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: date) // create   date from string
        return date
    }
    
    
    static func from(date dateStr: String, inFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: dateStr)
    }
    
    func toString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    
    func toLocalDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dateString = dateFormatter.string(from: self)
        return dateFormatter.date(from: dateString)
    }

    // TODO: Add Strings instead of constants
    /*
    func timeSince(from: NSDate, withFormat format: String) -> String {
        let calendar = Calendar.current
        let now = self as NSDate
        let earliest = now.earlierDate(from as Date)
        let latest = (earliest == now as Date ? from : now) as Date
        let components = calendar.dateComponents([.year, .weekOfYear, .month, .day, .hour, .minute, .second], from: earliest, to: latest as Date)
        
        let utcDate = Date.utcDate(fromString: latest.toString()!)
        if let res = utcDate?.toFormat(format: "h:mm a") {
            var result = res
            
            if let year = components.year, year >= 1 {
                result = "\(year) \(NSLocalizedString(Constants.LocalizedStringKeys.YEARS_AGO, comment: Constants.LocalizedStringKeys.YEARS_AGO))"
            }
            else if let month = components.month, month >= 1 {
                result = "\(month) \(NSLocalizedString(Constants.LocalizedStringKeys.MONTHS_AGO, comment: Constants.LocalizedStringKeys.MONTHS_AGO))"
            }
            else if let day = components.day, day >= 2 {
                result = "\(day) \(NSLocalizedString(Constants.LocalizedStringKeys.DAYS_AGO, comment: Constants.LocalizedStringKeys.DAYS_AGO))"
            }
            else if let day = components.day, day == 1 {
                result = "\(NSLocalizedString(Constants.LocalizedStringKeys.YESTERDAY, comment: Constants.LocalizedStringKeys.YESTERDAY)) \(result)"
            }
            else if let day = components.day, day == 0 {
                if let hour = components.hour, hour >= 1 {
                    result = "\(hour) \(NSLocalizedString(Constants.LocalizedStringKeys.HOURS_AGO, comment: Constants.LocalizedStringKeys.HOURS_AGO)) \(components.minute!) \(NSLocalizedString(Constants.LocalizedStringKeys.MINUTES_AGO, comment: Constants.LocalizedStringKeys.MINUTES_AGO))"
                } else if let minute = components.minute, minute >= 1 {
                    result = "\(minute) \(NSLocalizedString(Constants.LocalizedStringKeys.MINUTES_AGO, comment: Constants.LocalizedStringKeys.MINUTES_AGO))"
                } else {
                    result = "\(components.second!) \(NSLocalizedString(Constants.LocalizedStringKeys.SECONDS, comment: Constants.LocalizedStringKeys.SECONDS))"
                }
            }
            
            return result
        }
        
        return ""
    }
    
    
    func whatTime(withFormat format: String) -> String {
        let calendar = Calendar.current
        
        let earliest = self
        
        let components = calendar.dateComponents([.year, .weekOfYear, .month, .day, .hour, .minute, .second], from: earliest, to: earliest)
        
        let utcDate = Date.utcDate(fromString: earliest.toString()!)
        
        if let res = utcDate?.toFormat(format: "h:mm a") {
            var result = res
            
            if components.day! >= 2 {
                result = (utcDate?.toFormat(format: format)) ?? ""
            }
            else if components.day! == 1 {
                result = "\(NSLocalizedString(Constants.LocalizedStringKeys.YESTERDAY, comment: Constants.LocalizedStringKeys.YESTERDAY)) " + result
            }
            else if components.day! == 0 {
                result = "\(NSLocalizedString(Constants.LocalizedStringKeys.TODAY, comment: Constants.LocalizedStringKeys.TODAY)) " + result
            }
            
            return result
        }
        
        return ""
    }
    */
    
    func isLesserThan(date: Date)  -> Bool{
        let result = self.compare(date)
        
        return result == .orderedAscending
    }
    
    func isGreaterThan(date: Date)  -> Bool{
        let result = self.compare(date)
        
        return result == .orderedDescending
    }
    
    func isEqual(date: Date) -> Bool {
        let result = self.compare(date)
        
        return result == .orderedSame
    }
    
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}
