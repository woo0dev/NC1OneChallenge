//
//  InfoVM.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/06/29.
//

import SwiftUI

import Firebase
import FirebaseFirestore

class InfoVM: ObservableObject {
    let db = Firestore.firestore()
    var recordCount = 0
    var recordDates = [""]
    
    func fetchRecordCount(userUid: String) async throws {
        var isCounts: [Bool]
        let documents = try await db.collection("Record").getDocuments()
        isCounts = documents.documents.map({ (queryDocumentSnapshot) -> Bool in
            let data = queryDocumentSnapshot.data()
            if (data["userUid"] as? String ?? "") == userUid {
                return true
            } else {
                return false
            }
        })
        self.recordCount = (isCounts.filter { $0 == true }).count
    }
    
    func fetchMyAllRecord(userUid: String) async throws {
        let documents = try await db.collection("Record").getDocuments()
        recordDates = documents.documents.map({ (queryDocumentSnapshot) -> String in
            let data = queryDocumentSnapshot.data()
            if (data["userUid"] as? String ?? "") == userUid {
                return data["date"] as? String ?? ""
            } else {
                return ""
            }
        })
        self.recordDates = self.recordDates.filter { $0 != "" }
    }
    
    func editUserName(name: String) {
        let uid = Auth.auth().currentUser?.uid != nil ? Auth.auth().currentUser!.uid : ""
        Firestore.firestore().collection("User").document(uid).setData(["\(Auth.auth().currentUser!.uid)": ["uid": Auth.auth().currentUser!.uid, "name": name]])
    }
}
