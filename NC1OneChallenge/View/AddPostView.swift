//
//  AddPostView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/29.
//

import SwiftUI

struct AddPostView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var categoryName: String
    @Binding var posts: [post]
    @State var title: String = ""
    @State var description: String = ""
    @State private var imagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
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
                        Button(action: {
                            imagePickerPresented.toggle()
                        }, label: {
                            VStack {
                                let image = profileImage == nil ? Image(systemName: "plus.circle") : profileImage ?? Image(systemName: "plus.circle")
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
                            .frame(height: 250)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("MainColor"), lineWidth: 1)
                            )
                            .font(.custom("BMJUAOTF", size: 20))
                            .onAppear(perform: UIApplication.shared.hideKeyboard)
                        Button(action: {
                            let nowDate = Date()
                            posts.append(post(categoryName: categoryName, title: title, description: description, image: profileImage == nil ? Image(systemName: "plus.circle") : profileImage!, date: dateFormat(nowDate)))
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("등록하기")
                        }
                        .buttonStyle(customButtonStyle())
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
