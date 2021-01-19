//
//  URLNetwork.swift
//  TranslateApp
//
//  Created by Ngavt on 1/11/21.
//

import Foundation

class URLNetwork {
    func loadJson(fromURLString urlString: String,
                          completion: @escaping (String?, Error?) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Any]{
                        jsonArray.forEach {
                            if let innerArray = $0 as? [Any] {
                                innerArray.forEach {
                                    if let test = $0 as? [Any], test.count > 0 {
                                        completion(test[0] as? String, nil)
                                        return
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    print(error)
                    completion(nil, error)
                }
            }
            
            urlSession.resume()
        }
    }
}
