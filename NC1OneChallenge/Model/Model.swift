import SwiftUI
struct category: Hashable {
    var categoryName: String
    var categoryDescription: String
    var categoryImage: UIImage
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(categoryName)
        hasher.combine(categoryDescription)
    }
}
struct post: Hashable {
    var user: String
    var categoryName: String
    var title: String
    var description: String
    var image: UIImage
    var date: String
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(categoryName)
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(date)
    }
    
    var dictionary: [String: Any] {
            return [
                "user": user,
                "categoryName": categoryName,
                "title": title,
                "description": description,
                "date": date,
                "image": image,
            ]
        }
}
struct user {
    var UUID: String
    var name: String
}
