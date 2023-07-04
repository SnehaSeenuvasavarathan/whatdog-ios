//
//  WhatDogAPI.swift
//  WhatDog
//
//  Created by Sneha Seenuvasavarathan on 6/6/23.
//

import UIKit

final class WhatDogAPI {
    
    private static let apiURL = "http://3.141.29.133/"
    
    static func predictWithImage(image: UIImage, completion: @escaping (String) -> Void) {
        
        if let url = URL(string: "\(apiURL)predict") {
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            let boundary = UUID().uuidString
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            var data = Data()
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"image\"; filename=\"file.png\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            data.append(image.pngData()!)
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.uploadTask(with: urlRequest, from: data) { (data, response, error) in
                guard error == nil else {
                    completion("Error")
                    return
                }
                if let safeData = data {
                    print(safeData)
                    if let string = String(data: safeData, encoding: .utf8) {
                        print(string)
                    }
                    completion("Golden Retriever")
                } else {
                    completion("Error")
                }
                return
            }
            task.resume()
        } else {
            completion("Error")
        }
    }
    
    static func addImagesToTrain(images: [UIImage], breed: Breed, completion: @escaping (String) -> Void) {
        
        if let url = URL(string: "\(apiURL)update") {
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            let boundary = UUID().uuidString
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            var data = Data()
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"image\"; filename=\"file.png\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            data.append(images[0].pngData()!)
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.uploadTask(with: urlRequest, from: data) { (data, response, error) in
                guard error == nil else {
                    completion("Error")
                    return
                }
                if let safeData = data {
                    print(safeData)
                    completion("Trained successfully!")
                } else {
                    completion("Error")
                }
                return
            }
            task.resume()
        } else {
            completion("Error")
        }
    }
    
    static func addNewBreedAndImages(images: [UIImage], breed: String, completion: @escaping (String) -> Void) {
        
        if let url = URL(string: "\(apiURL)new_class") {
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            let boundary = UUID().uuidString
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            var data = Data()
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"image\"; filename=\"file.png\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            data.append(images[0].pngData()!)
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.uploadTask(with: urlRequest, from: data) { (data, response, error) in
                guard error == nil else {
                    completion("Error")
                    return
                }
                if let safeData = data {
                    print(safeData)
                    completion("Added new class successfully :)")
                } else {
                    completion("Error")
                }
                return
            }
            task.resume()
        } else {
            completion("Error")
        }
    }
}
