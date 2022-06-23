//
//  CategoryVM.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/06/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

class categoryVM: ObservableObject {
    let db = Firestore.firestore()
    var allCategories: [category] = [category(categoryUid: "", adminName: "", participants: [""], categoryName: "", categoryDescription: "", categoryImage: "")]
    var myCategories: [category] = [category(categoryUid: "", adminName: "", participants: [""], categoryName: "", categoryDescription: "", categoryImage: "")]
    
    func addCategory(category: category) {
        db.collection("category").document(category.categoryUid).updateData(category.dictionary)
    }
    
    func deleteCategory(category: category) {
        db.collection("category").document(category.categoryUid).delete()
    }
    
    func editCategory(category: category) {
        db.collection("category").document(category.categoryUid).updateData(category.dictionary)
    }
    
    func fetchAllCategories() {
        db.collection("category").getDocuments() { (querySnapShot, error) in
            guard let documents = querySnapShot?.documents else {
                print("No Documents")
                return
            }
            
            self.allCategories = documents.map({ (queryDocumentSnapshot) -> category in
                let data = queryDocumentSnapshot.data()
                let categoryUid = data["categoryUid"] as? String ?? ""
                let adminName = data["adminName"] as? String ?? ""
                let participants = data["participants"] as? [String] ?? [""]
                let categoryName = data["categoryName"] as? String ?? ""
                let categoryDescription = data["categoryDescription"] as? String ?? ""
                let categoryImage = data["categoryImage"] as? String ?? ""
                return category(categoryUid: categoryUid, adminName: adminName, participants: participants, categoryName: categoryName, categoryDescription: categoryDescription, categoryImage: categoryImage)
            })
        }
    }
    
    func fetchMyCategories(uid: String) {
        db.collection("category").getDocuments() { (querySnapShot, error) in
            guard let documents = querySnapShot?.documents else {
                print("No Documents")
                return
            }
            
            let results = documents.map({ (queryDocumentSnapshot) -> category in
                let data = queryDocumentSnapshot.data()
                if (data["participants"] as? [String] ?? [""]).contains(uid) {
                    let categoryUid = data["categoryUid"] as? String ?? ""
                    let adminName = data["adminName"] as? String ?? ""
                    let participants = data["participants"] as? [String] ?? [""]
                    let categoryName = data["categoryName"] as? String ?? ""
                    let categoryDescription = data["categoryDescription"] as? String ?? ""
                    let categoryImage = data["categoryImage"] as? String ?? ""
                    return category(categoryUid: categoryUid, adminName: adminName, participants: participants, categoryName: categoryName, categoryDescription: categoryDescription, categoryImage: categoryImage)
                } else {
                    return category(categoryUid: "", adminName: "", participants: [""], categoryName: "", categoryDescription: "", categoryImage: "")
                }
            })
            
            self.myCategories = results.filter { $0.categoryUid != "" }
        }
    }
    

}
