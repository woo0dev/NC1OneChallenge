import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

func dateFormat(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
}