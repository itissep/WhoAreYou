//
//  Networking.swift
//  WhoAreYou
//
//  Created by The GORDEEVS on 15.03.2022.
//

import UIKit

struct AgeManager {
    
    let ageURL = "https://api.agify.io?name="
    
    func fetchAge(name: String, _ complitionHandler: @escaping (AgeData) -> Void) {
        let urlString = self.ageURL + name
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                        let age = try? JSONDecoder().decode(AgeData.self, from: safeData)
                        complitionHandler(age ?? AgeData(age: 0))
                }
            }
            task.resume()
        }
    }
}

struct AgeData: Codable {
    let age: Int
}

