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
}
