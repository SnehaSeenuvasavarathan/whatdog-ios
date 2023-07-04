//
//  NewBreedView.swift
//  WhatDog
//
//  Created by Sneha Seenuvasavarathan on 4/8/23.
//

import SwiftUI
import PhotosUI

struct NewBreedView: View {
    
    @EnvironmentObject var newBreedViewModel: NewBreedViewModel
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var newBreedName: String = ""
    let size = (UIScreen.main.bounds.size.width/3) - 4
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
            switch newBreedViewModel.stage {
            case .requestImages:
                    VStack {
                        PhotosPicker(selection: $selectedItems,
                                     maxSelectionCount: 9,
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
                        .onChange(of: selectedItems) { newItems in
                            Task {
                                var images: [UIImage] = []
                                for item in newItems {
                                    if let data = try? await item.loadTransferable(type: Data.self) {
                                        images.append(UIImage(data: data)!)
                                    }
                                }
                                newBreedViewModel.setImages(images: images)
                            }
                        }
                        Spacer(minLength: 20)
                        Text("Upload new dog images of unknow breeds")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        Spacer(minLength: 80)
                    }
                    .frame(width: 200, height:200)
            case .imagesSelected:
                VStack {
                    ImageGridView(images: newBreedViewModel.images,
                                  size: size)
                        .body
                        .frame(width: UIScreen.main.bounds.size.width,
                               height: UIScreen.main.bounds.size.width)
                    Spacer(minLength: 20)
                    HStack {
                        Spacer(minLength: 15)
                        TextField(text: $newBreedName) {
                            Text(newBreedViewModel.errorReaction)
                        }
                        Spacer(minLength: 15)
                    }
                    .frame(width: UIScreen.main.bounds.size.width-100, height: 45)
                    .background(Color(uiColor: UIColor.tertiarySystemGroupedBackground))
                    .cornerRadius(ImageRenderHelper.cornerRadius/2)
                    Spacer(minLength: 20)
                    Button(action: {
                        
                        if newBreedViewModel.setBreed(breedString: newBreedName) {
                            newBreedViewModel.addNewBreed()
                        } else {
                            newBreedName = ""
                        }
                    }) {
                        Text("Train \(newBreedName)")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                    .foregroundColor(Color.white)
                }
                .frame(width: UIScreen.main.bounds.size.width, height:500)
            case .process:
                VStack {
                    ImageGridView(images: newBreedViewModel.images,
                                  size: size)
                        .body
                        .frame(width: UIScreen.main.bounds.size.width,
                               height: UIScreen.main.bounds.size.width)
                    Spacer(minLength: 20+45+20)
                    Text("Processing...")
                }
                .frame(width: UIScreen.main.bounds.size.width, height:500)
            case .finished:
                VStack {
                    ImageGridView(images: newBreedViewModel.images,
                                  size: size)
                        .body
                        .frame(width: UIScreen.main.bounds.size.width,
                               height: UIScreen.main.bounds.size.width)
                    Spacer(minLength: 20)
                    Text(newBreedViewModel.response)
                    Spacer(minLength: 20)
                    Button(action: newBreedViewModel.reset) {
                        Text("Train more")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                    .foregroundColor(Color.white)
                }
                .frame(width: UIScreen.main.bounds.size.width, height:500)
            }
        }
    }
}
