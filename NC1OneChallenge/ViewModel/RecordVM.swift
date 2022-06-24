//
//  RecordVM.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/06/24.
//

import SwiftUI

import Firebase
import FirebaseFirestore

class RecordVM: ObservableObject {
    let db = Firestore.firestore()
    
    
    func addCategory(category: category) {
        db.collection("Category").document(category.categoryUid).updateData(category.dictionary)
    }
    
    func deleteCategory(category: category) {
        db.collection("Category").document(category.categoryUid).delete()
    }
    
    func editCategory(category: category) {
        db.collection("Category").document(category.categoryUid).updateData(category.dictionary)
    }
    
    func fetchAllCategories() {
        db.collection("Category").getDocuments() { (querySnapShot, error) in
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
//                let categoryImage = data["categoryImage"] as? String ?? ""
                return category(categoryUid: categoryUid, adminName: adminName, participants: participants, categoryName: categoryName, categoryDescription: categoryDescription)
            })
        }
    }
    
    func fetchMyCategories(uid: String) {
        db.collection("Category").getDocuments() { (querySnapShot, error) in
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
//                    let categoryImage = data["categoryImage"] as? String ?? ""
                    return category(categoryUid: categoryUid, adminName: adminName, participants: participants, categoryName: categoryName, categoryDescription: categoryDescription)
                } else {
                    return category(categoryUid: "", adminName: "", participants: [""], categoryName: "", categoryDescription: "")
                }
            })
            
            self.myCategories = results.filter { $0.categoryUid != "" }
        }
    }
    

}
