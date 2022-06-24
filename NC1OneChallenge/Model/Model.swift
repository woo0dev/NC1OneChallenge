import SwiftUI
struct Category: Hashable {
    var categoryUid = UUID().uuidString
    var adminName: String
    var participants: [String]
    var categoryName: String
    var categoryDescription: String
//    var categoryImage: String
    
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
//            "categoryImage": categoryImage,
        ]
    }
}
struct Record: Hashable {
    var userName: String
    var categoryName: String
    var title: String
    var description: String
//    var image: String
    var date: String
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(categoryName)
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(date)
    }
    
    var dictionary: [String: String] {
        return [
            "user": userName,
            "categoryName": categoryName,
            "title": title,
            "description": description,
            "date": date,
//            "image": image,
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
