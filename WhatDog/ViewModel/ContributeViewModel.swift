//
//  ContributeViewModel.swift
//  WhatDog
//
//  Created by Sneha Seenuvasavarathan on 4/8/23.
//

import SwiftUI

enum ContributeStage {
    case requestImages, imagesSelected, process, finished
}

class ContributeViewModel: ObservableObject {
    
    var images: [UIImage] = []
    var breed: Breed = .labrador
    var response: String = ""
    @Published var stage: ContributeStage = .requestImages
    
    func setImages(images: [UIImage]) {
        self.images = images
        stage = .imagesSelected
    }
    
    func setBreed(breed: Breed) {
        self.breed = breed
    }
    
    func contribute() {
        stage = .process
        WhatDogAPI.addImagesToTrain(images: images, breed: breed) { response in
            self.response = response
            self.stage = .finished
        }
    }
    
    func reset(){
        stage = .requestImages
    }
}
