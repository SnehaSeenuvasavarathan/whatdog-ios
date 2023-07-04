//
//  Breed.swift
//  WhatDog
//
//  Created by Sneha Seenuvasavarathan on 4/6/23.
//

import Foundation

enum Breed: String, CaseIterable, Equatable {
    case labrador = "Labrador", golden_retriever = "Golden Retriever", german_shepherd = "German Shepherd"

    static var stringValues: Set<String> {["Labrador", "Golden Retriever", "German Shepherd"]}
}
