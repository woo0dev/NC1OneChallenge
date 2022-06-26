import SwiftUI
struct Category: Hashable {
    var categoryUid = UUID().uuidString
    var adminName: String
    var participants: [String]
    var categoryName: String
    var categoryDescription: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(categoryName)
        hasher.combine(categoryDescription)
    }
    
    var dictionary: [String: Any] {
        return [
            "categoryUid": categoryUid,
            "adminName": adminName,
            "participants": participants,
            "categoryName": categoryName,
            "categoryDescription": categoryDescription,
        ]
    }
}
struct Record: Hashable {
    var recordUid: String
    var userName: String
    var categoryName: String
    var text: String
    var date: String
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(categoryName)
        hasher.combine(text)
        hasher.combine(date)
    }
    
    var dictionary: [String: String] {
        return [
            "recordUid": recordUid,
            "userName": userName,
            "categoryName": categoryName,
            "text": text,
            "date": date,
        ]
    }
}

struct User {
    var Uid: String
    var name: String
    
    var dictionary: [String: String] {
        return [
            "Uid": Uid,
            "name": name,
        ]
    }
}

enum CategoryPicker: String, CaseIterable {
    case all = "모든 카테고리"
    case my = "나의 카테고리"
}
