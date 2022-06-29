//
//  Parser.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 27/06/22.
//

import Foundation

struct Parser <T: Codable> {
    func fetchData(withURL urlString: String, _ completionHandler: @escaping ((T?) -> Void)){
        guard let url = URL(string: urlString) else {
            return
        }

        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
                return
            } else {
                guard let data = data else {
                    return
                }
                
                let model = try? JSONDecoder().decode(T.self, from: data)
                completionHandler(model)
            }
        }
        task.resume()
    }
}



