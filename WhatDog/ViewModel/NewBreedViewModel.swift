//
//  NewBreedViewModel.swift
//  WhatDog
//
//  Created by Sneha Seenuvasavarathan on 4/9/23.
//

import SwiftUI

class NewBreedViewModel: ObservableObject {
    
    var images: [UIImage] = []
    var breedString: String = "Husky"
    var response: String = ""
    @Published var stage: ContributeStage = .requestImages
    @Published var errorReaction: String = "Enter new breed:"
    
    func setImages(images: [UIImage]) {
        self.images = images
        stage = .imagesSelected
    }
    
    func setBreed(breedString: String) -> Bool {
        if (breedString.isEmpty || Breed.stringValues.contains(breedString.capitalized)) {
            errorReaction = "Breed exists"
            return false
        }
        self.breedString = breedString
        return true
    }
    
    func addNewBreed() {
        stage = .process
        WhatDogAPI.addNewBreedAndImages(images: images, breed: breedString) { response in
            self.response = response
            self.stage = .finished
        }
    }
    
    func reset(){
        stage = .requestImages
        errorReaction = "Enter new breed:"
    }
}
