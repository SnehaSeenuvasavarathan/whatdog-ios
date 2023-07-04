//
//  ContentView.swift
//  WhatDog
//
//  Created by Sneha Seenuvasavarathan on 4/2/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var predictViewModel: PredictViewModel = PredictViewModel()
    @StateObject var contributeViewModel: ContributeViewModel = ContributeViewModel()
    @StateObject var newBreedViewModel: NewBreedViewModel = NewBreedViewModel()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.tertiarySystemGroupedBackground
        UITabBar.appearance().isTranslucent = true
    }
    
    var body: some View {
        TabView {
            Group {
                PredictView()
                    .tabItem {Label("Predict", systemImage: "magnifyingglass")}
                    .environmentObject(predictViewModel)
                ContributeView()
                    .tabItem {Label("Contribute", systemImage: "sparkles")}
                    .environmentObject(contributeViewModel)
                NewBreedView()
                    .tabItem {Label("New Breed", systemImage: "lasso.and.sparkles")}
                    .environmentObject(newBreedViewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
