import SwiftUI
struct category: Hashable {
    var categoryName: String
    var categoryDescription: String
    var categoryImage: Image
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(categoryName)
        hasher.combine(categoryDescription)
    }
}
struct post: Hashable {
    var categoryName: String
    var title: String
    var description: String
    var image: Image
    var date: String
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(categoryName)
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(date)
    }
}
struct user {
    var UUID: UUID
    var name: String
}
