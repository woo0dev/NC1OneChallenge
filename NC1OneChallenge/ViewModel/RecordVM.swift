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
    var allRecord = [Record(recordUid: "", userUid: "", userName: "", categoryName: "", date: "")]
    var myRecord = [Record(recordUid: "", userUid: "", userName: "", categoryName: "", date: "")]
    
    func addRecord(record: Record) {
        db.collection("Record").document(record.recordUid).setData(record.dictionary)
    }
    
    func deleteRecord(record: Record) {
        db.collection("Record").document(record.recordUid).delete()
    }
    
    func fetchAllRecord(categoryName: String) {
        db.collection("Record").getDocuments() { (querySnapShot, erro) in
            guard let documents = querySnapShot?.documents else {
                print("No Record")
                return
            }
            
            let results = documents.map({ (queryDocumentSnapshot) -> Record in
                let data = queryDocumentSnapshot.data()
                if (data["categoryName"] as? String ?? "") == categoryName {
                    let recordUid = data["recordUid"] as? String ?? ""
                    let userUid = data["userUid"] as? String ?? ""
                    let userName = data["userName"] as? String ?? ""
                    let categoryName = data["categoryName"] as? String ?? ""
                    let date = data["date"] as? String ?? ""
                    return Record(recordUid: recordUid, userUid: userUid, userName: userName, categoryName: categoryName, date: date)
                } else {
                    return Record(recordUid: "", userUid: "", userName: "", categoryName: "", date: "")
                }
            })
            
            self.allRecord = results.filter { $0.recordUid != "" }
        }
    }
    
    func fetchMyRecord(categoryName: String, userUid: String) async throws {
        let documents = try await db.collection("Record").getDocuments()
        self.myRecord = documents.documents.map({ (queryDocumentSnapshot) -> Record in
            let data = queryDocumentSnapshot.data()
            if (data["categoryName"] as? String ?? "") == categoryName && (data["userUid"] as? String ?? "") == userUid {
                let recordUid = data["recordUid"] as? String ?? ""
                let userUid = data["userUid"] as? String ?? ""
                let userName = data["userName"] as? String ?? ""
                let categoryName = data["categoryName"] as? String ?? ""
                let date = data["date"] as? String ?? ""
                return Record(recordUid: recordUid, userUid: userUid, userName: userName, categoryName: categoryName, date: date)
            } else {
                return Record(recordUid: "", userUid: "", userName: "", categoryName: "", date: "")
            }
        })
        self.myRecord = self.myRecord.filter { $0.recordUid != "" }
    }
}
