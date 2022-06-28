func calendarColor(_ dates: [String], date: String) -> String {
    let count = (dates.filter { $0 == date }).count
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
