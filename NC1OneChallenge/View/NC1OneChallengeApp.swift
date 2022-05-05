//
//  NC1OneChallengeApp.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/28.
//

import SwiftUI
import Firebase

@main
struct NC1OneChallengeApp: App {
    
//    @State var posts: [post]
    
    init() {
        FirebaseApp.configure()
//        fetchPost()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
//    func fetchPost() {
//        let db = Firestore.firestore()
//        db.collection("OneChallenge").getDocuments() { [self] (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//                print("No Documents")
//                return
//            }
//
//            self.posts = documents.map({ (queryDocumentSnapshot) -> post in
//                let data = queryDocumentSnapshot.data()
//                let user = data["user"] as? String ?? "blank id"
//                let categoryName = data["categoryName"] as? String ?? "blank categoryName"
//                let title = data["title"] as? String ?? "blank title"
//                let description = data["description"] as? String ?? "blank description"
//                let date = data["date"] as? String ?? ""
//                let image = data["image"] as? String ?? ""
//
//                return post(user: user, categoryName: categoryName, title: title, description: description, image: fetchImage(postId: user, imageName: image), date: date)
//            })
//        }
//
//    }
//
//
//    func fetchImage(postId: String, imageName: String) -> UIImage {
//        var storage = Storage.storage()
//        let ref = storage.reference().child("images/\(postId)/\(imageName)").getData(maxSize: 1 * 1024 * 1024) { data, error in
//            if let error = error {
//                print("error while downloading image\n\(error.localizedDescription)")
//                return
//            } else {
//                let image = UIImage(data: data!)!
//            }
//        }
//
//
//    }
}
