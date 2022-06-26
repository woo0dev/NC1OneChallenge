//
//  CategoryVM.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/06/23.
//

import SwiftUI

import Firebase
import FirebaseFirestore

class CategoryVM: ObservableObject {
    let db = Firestore.firestore()
    @Published var allCategories: [Category] = [Category(categoryUid: "", adminName: "", participants: [""], categoryName: "", categoryDescription: "")]
    @Published var myCategories: [Category] = [Category(categoryUid: "", adminName: "", participants: [""], categoryName: "", categoryDescription: "")]
    
    func addCategory(category: Category) {
        db.collection("Category").document(category.categoryUid).setData(category.dictionary)
    }
    
    func deleteCategory(category: Category) {
        db.collection("Category").document(category.categoryUid).delete()
    }
    
    func editCategory(category: Category) {
        db.collection("Category").document(category.categoryUid).setData(category.dictionary)
    }
    
    func fetchAllCategories() {
        db.collection("Category").getDocuments() { (querySnapShot, error) in
            guard let documents = querySnapShot?.documents else {
                print("No Documents")
                return
            }
            
            self.allCategories = documents.map({ (queryDocumentSnapshot) -> Category in
                let data = queryDocumentSnapshot.data()
                let categoryUid = data["categoryUid"] as? String ?? ""
                let adminName = data["adminName"] as? String ?? ""
                let participants = data["participants"] as? [String] ?? [""]
                let categoryName = data["categoryName"] as? String ?? ""
                let categoryDescription = data["categoryDescription"] as? String ?? ""
//                let categoryImage = data["categoryImage"] as? String ?? ""
                return Category(categoryUid: categoryUid, adminName: adminName, participants: participants, categoryName: categoryName, categoryDescription: categoryDescription)
            })
        }
    }
    
    func fetchAll(_ completion: @escaping (_ data: [Category]) -> Void) {
        var categories = [Category(categoryUid: "", adminName: "", participants: [""], categoryName: "", categoryDescription: "")]
        
        let g = DispatchGroup()
        g.enter()
        
        db.collection("Category").getDocuments() { (querySnapShop, error) in
            guard let documents = querySnapShop?.documents else {
                print("No Documents")
                return
            }
            
            categories = documents.map({ (queryDocumentSnapshot) -> Category in
                let data = queryDocumentSnapshot.data()
                let categoryUid = data["categoryUid"] as? String ?? ""
                let adminName = data["adminName"] as? String ?? ""
                let participants = data["participants"] as? [String] ?? [""]
                let categoryName = data["categoryName"] as? String ?? ""
                let categoryDescription = data["categoryDescription"] as? String ?? ""
//                let categoryImage = data["categoryImage"] as? String ?? ""
                return Category(categoryUid: categoryUid, adminName: adminName, participants: participants, categoryName: categoryName, categoryDescription: categoryDescription)
            })
            
            g.leave()
            
        }
        
        g.notify(queue: .main) {
            completion(categories)
        }
        
        return
    }
    
    func fetchMyCategories(uid: String) {
        db.collection("Category").getDocuments() { (querySnapShot, error) in
            guard let documents = querySnapShot?.documents else {
                print("No Documents")
                return
            }
            
            let results = documents.map({ (queryDocumentSnapshot) -> Category in
                let data = queryDocumentSnapshot.data()
                if (data["participants"] as? [String] ?? [""]).contains(uid) {
                    let categoryUid = data["categoryUid"] as? String ?? ""
                    let adminName = data["adminName"] as? String ?? ""
                    let participants = data["participants"] as? [String] ?? [""]
                    let categoryName = data["categoryName"] as? String ?? ""
                    let categoryDescription = data["categoryDescription"] as? String ?? ""
//                    let categoryImage = data["categoryImage"] as? String ?? ""
                    return Category(categoryUid: categoryUid, adminName: adminName, participants: participants, categoryName: categoryName, categoryDescription: categoryDescription)
                } else {
                    return Category(categoryUid: "", adminName: "", participants: [""], categoryName: "", categoryDescription: "")
                }
            })
            
            self.myCategories = results.filter { $0.categoryUid != "" }
        }
    }
    

}
