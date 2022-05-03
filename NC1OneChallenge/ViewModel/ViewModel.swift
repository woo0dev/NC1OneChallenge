import SwiftUI

func dateFormat(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
}

func calendarColor(_ dates: [String], date: Date) -> String {
    var count = 0
    for d in dates {
        if d == dateFormat(date) {
            count += 1
        }
    }
    switch count {
    case 0:
        return "CalendarColor"
    case 1:
        return "CalendarColor1"
    case 2:
        return "CalendarColor2"
    case 3:
        return "CalendarColor3"
    case 4:
        return "CalendarColor4"
    case 5:
        return "CalendarColor5"
    default:
        return "CalendarColor6"
    }
}
