//
//  PredictView.swift
//  WhatDog
//
//  Created by Sneha Seenuvasavarathan on 4/2/23.
//

import SwiftUI
import PhotosUI

struct PredictView: View {
    
    @EnvironmentObject var predictViewModel: PredictViewModel
    @State private var selectedItem: [PhotosPickerItem] = []
    
    func reset() {
        predictViewModel.stage = .requestImage
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
            switch predictViewModel.stage {
            case .requestImage:
                    VStack {
                        PhotosPicker(selection: $selectedItem,
                                     maxSelectionCount: 1,
                                     matching: .images,
                                     photoLibrary: .shared()) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .frame(width: 150, height: 150)
                                .background(Color(UIColor.secondarySystemBackground))
                        }
                        .foregroundColor(.accentColor)
                        .frame(width: 150, height: 150)
                        .cornerRadius(ImageRenderHelper.cornerRadius)
                        .onChange(of: selectedItem) { newItem in
                            Task {
                                if let data = try? await newItem.first?.loadTransferable(type: Data.self) {
                                    predictViewModel.setImage(image: UIImage(data: data)!)
                                }
                            }
                        }
                        Spacer(minLength: 20)
                        Text("Upload a dog image to know what breed it is")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        Spacer(minLength: 80)
                    }
                    .frame(width: 200, height:200)
            case .imageSelected:
                VStack {
                    let (height, width) = ImageRenderHelper.computeDimensions(for: predictViewModel.image,
                                                                              maxWidth: UIScreen.main.bounds.size.width)
                    Image(uiImage: predictViewModel.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width, height: height)
                    Spacer(minLength: 20)
                    Button(action: predictViewModel.makePrediction) {
                        Text("Predict Breed")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                    .foregroundColor(Color.white)
                }
                .frame(width: 500, height:500)
            case .process:
                VStack {
                    let (height, width) = ImageRenderHelper.computeDimensions(
                        for: predictViewModel.image,
                        maxWidth: UIScreen.main.bounds.size.width
                    )
                    Image(uiImage: predictViewModel.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width, height: height)
                    Spacer(minLength: 20)
                    Text("Processing..")
                }
                .frame(width: 500, height:500)
            case .finished:
                VStack {
                    let (height, width) = ImageRenderHelper.computeDimensions(
                        for: predictViewModel.image,
                        maxWidth: UIScreen.main.bounds.size.width
                    )
                    Image(uiImage: predictViewModel.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width, height: height)
                    Spacer(minLength: 20)
                    Text("It's a \(predictViewModel.prediction)!")
                    Spacer(minLength: 20)
                    Button(action: predictViewModel.reset) {
                        Text("Try a different picture")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                    .foregroundColor(Color.white)
                }
                .frame(width: 500, height:500)
            }
        }
    }
}

struct PredictView_Previews: PreviewProvider {
    static var previews: some View {
        PredictView()
    }
}

struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode)
    var presentationMode

    @Binding var image: Image?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        @Binding var presentationMode: PresentationMode
        @Binding var image: Image?

        init(presentationMode: Binding<PresentationMode>, image: Binding<Image?>) {
            _presentationMode = presentationMode
            _image = image
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            image = Image(uiImage: uiImage)
            presentationMode.dismiss()

        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

}
