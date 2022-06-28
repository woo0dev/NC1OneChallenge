import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

func dateToStringFormat(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return dateFormatter.string(from: date)
}

func dateWithTimeRemoved(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
}

func stringToDateFormat(_ date: String) -> Date {
    let stringFormatter = DateFormatter()
    stringFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return stringFormatter.date(from: date) != nil ? stringFormatter.date(from: date)! : Date()
}
