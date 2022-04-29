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
}
