//
//  PredictViewModel.swift
//  WhatDog
//
//  Created by Sneha Seenuvasavarathan on 4/2/23.
//

import SwiftUI

enum PredictStage {
    case requestImage, imageSelected, process, finished
}

class PredictViewModel: ObservableObject {
    
    var image: UIImage = UIImage(systemName: "plus")!
    var prediction: String = "Husky"
    @Published var stage: PredictStage = .requestImage
    
    func setImage(image: UIImage) {
        self.image = image
        stage = .imageSelected
    }
    
    func makePrediction() {
        stage = .process
        WhatDogAPI.predictWithImage(image: image) { response in
            self.prediction = response
            self.stage = .finished
        }
    }
    
    func reset(){
        stage = .requestImage
    }
}
