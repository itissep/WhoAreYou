//
//  GenderManager.swift
//  WhoAreYou
//
//  Created by The GORDEEVS on 15.03.2022.
//

import Foundation

struct GenderManager {
    
    let genderURL = "https://api.genderize.io?name="

    func fetchGender(name: String, _ complitionHandler: @escaping (GenderData) -> Void) {
        let urlString = self.genderURL + name
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let gender = try? JSONDecoder().decode(GenderData.self, from: safeData)
                    complitionHandler(gender ?? GenderData(gender: "none"))
                }
            }
            task.resume()
        }
    }
}

struct GenderData: Codable {
    let gender: String
}
