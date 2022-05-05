//
//  AddPostView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/29.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct AddPostView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var categoryName: String
    @Binding var posts: [post]
    @State var title: String = ""
    @State var description: String = ""
    @State private var imagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    
    let db = Firestore.firestore()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    VStack {
                        Text("\(categoryName)")
                            .font(.custom("BMJUAOTF", size: 40))
                            .foregroundColor(Color("MainColor"))
                            .padding(10)
                    }
                    VStack(alignment: .leading) {
                        VStack(alignment: .center) {
                            Button(action: {
                                imagePickerPresented.toggle()
                            }, label: {
                                VStack {
                                    let image = profileImage ?? Image(systemName: "plus.circle")
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 64, height: 64)
                                        .clipShape(Circle())
                                    Text("사진 선택하기")
                                        .foregroundColor(Color("BlackColor"))
                                }
                                .padding(20)
                            })
                            .sheet(isPresented: $imagePickerPresented,
                                   onDismiss: loadImage,
                                   content: { ImagePicker(image: $selectedImage) })
                            .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("MainColor"), lineWidth: 1)
                                    )
                            .padding(.bottom, 20)
                        }
                        .frame(width: geometry.size.width-20, height: 100, alignment: .center)
                        Text("제목")
                            .font(.custom("BMJUAOTF", size: 30))
                        TextField("", text: $title)
                            .frame(width: geometry.size.width-39, height: 40)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("MainColor"), lineWidth: 1)
                            )
                            .font(.custom("BMJUAOTF", size: 20))
                            .onAppear(perform: UIApplication.shared.hideKeyboard)
                        Text("설명")
                            .font(.custom("BMJUAOTf", size: 30))
                        TextEditor(text: $description)
                            .frame(width: geometry.size.width-39, height: 250, alignment: .leading)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("MainColor"), lineWidth: 1)
                            )
                            .font(.custom("BMJUAOTF", size: 20))
                            .onAppear(perform: UIApplication.shared.hideKeyboard)
                        Button(action: {
                            let nowDate = Date()
                            if Auth.auth().currentUser?.uid != nil {
//                                db.collection("OneChallenge").document("posts").setData(["\(nowDate)": ["user": Auth.auth().currentUser!.uid, "categoryName": categoryName, "title": title, "description": description, "image": selectedImage]])
                                posts.append(post(user: Auth.auth().currentUser!.uid, categoryName: categoryName, title: title, description: description, image: selectedImage == nil ? UIImage(systemName: "plus.circle")! : selectedImage!, date: dateFormat(nowDate)))
                                uploadPost(post: post(user: Auth.auth().currentUser!.uid, categoryName: categoryName, title: title, description: description, image: selectedImage == nil ? UIImage(systemName: "plus.circle")! : selectedImage!, date: dateFormat(nowDate)))
                            }
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("등록하기")
                        }
                        .buttonStyle(customButtonStyle())
                        .padding(.trailing, 20)
                    }
                    .padding(20)
                }
            }
        }
    }
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}
