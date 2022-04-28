import SwiftUI
struct category: Hashable {
    var categoryName: String
    var categoryDescription: String
    var categoryImage: String
}
struct post: Hashable {
    var categoryName: String
    var title: String
    var description: String
}
