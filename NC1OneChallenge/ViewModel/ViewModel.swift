import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

func dateFormat(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
}

func calendarColor(_ dates: [String], date: Date) -> String {
    var count = 0
    for d in dates {
        if d == dateFormat(date) {
            count += 1
        }
    }
    switch count {
    case 0:
        return "CalendarColor"
    case 1:
        return "CalendarColor1"
    case 2:
        return "CalendarColor2"
    case 3:
        return "CalendarColor3"
    case 4:
        return "CalendarColor4"
    case 5:
        return "CalendarColor5"
    default:
        return "CalendarColor6"
    }
}
//db.collection("OneChallenge").document("posts").setData(["\(nowDate)": ["user": Auth.auth().currentUser!.uid, "categoryName": categoryName, "title": title, "description": description, "image": selectedImage]])
func uploadPost(post: post) {
    let db = Firestore.firestore()
    let imgName = UUID().uuidString
    uploadImage(image: post.image, name: (post.user + "/" + imgName))
    let _ = db.collection("OneChallenge").document("posts").setData(["\(post.user)": ["user": Auth.auth().currentUser!.uid, "categoryName": post.categoryName, "title": post.title, "description": post.description, "date": post.date, "image": imgName]])
}

func uploadImage(image: UIImage, name: String) {
    let storage = Storage.storage()
    let storageRef = storage.reference().child("images/\(name)")
    let data = image.jpegData(compressionQuality: 0.1)
    let metadata = StorageMetadata()
    metadata.contentType = "image/jpg"

    // uploda data
    if let data = data {
        storageRef.putData(data, metadata: metadata) { (metadata, err) in
            if let err = err {
                print("err when uploading jpg\n\(err)")
            }

            if let metadata = metadata {
                print("metadata: \(metadata)")
            }
        }
    }

}

