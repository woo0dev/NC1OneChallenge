//
//  AddCategoryView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/28.
//

import SwiftUI

struct AddCategoryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var categorys: [category]
    @State var categoryName: String = ""
    @State var categoryDescription: String = ""
    @State private var imagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    var body: some View {
        ScrollView {
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
                Text("습관 이름")
                    .font(.custom("BMJUAOTF", size: 30))
                TextField("", text: $categoryName)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("MainColor"), lineWidth: 1)
                    )
                    .font(.custom("BMJUAOTF", size: 30))
                    .onAppear(perform: UIApplication.shared.hideKeyboard)
                Text("설명")
                    .font(.custom("BMJUAOTf", size: 30))
                TextEditor(text: $categoryDescription)
                    .frame(height: 300)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("MainColor"), lineWidth: 1)
                    )
                    .font(.custom("BMJUAOTF", size: 30))
                    .onAppear(perform: UIApplication.shared.hideKeyboard)
                Button(action: {
                    categorys.append(category(categoryName: categoryName, categoryDescription: categoryDescription, categoryImage: profileImage == nil ? Image(systemName: "plus.circle") : profileImage!))
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("등록하기")
                }
                .buttonStyle(customButtonStyle())
            }
            .padding(20)
        }
    }
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

