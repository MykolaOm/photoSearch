//
//  NetworkService.swift
//  searchPhoto
//
//  Created by Nikolas Omelianov on 9/14/19.
//  Copyright © 2019 Nikolas Omelianov. All rights reserved.
//

import SwiftyJSON

class NetworkService {
    private init() {}
    static let shared = NetworkService()
    var requestedItemsNumb: Int = 0
    
    func getUrlWith(param:String, urlString: String) -> URL? {
        var urlComp = URLComponents(string: urlString)
        urlComp?.queryItems = [
            URLQueryItem(name: Unsplash.queryKey, value: param),
            URLQueryItem(name: Unsplash.clientKey, value: Unsplash.clienId)
        ]
        guard let url = urlComp?.url else { return nil }
        return url
    }
    func getRequest(to url: URL, completion: @escaping (String, URL?)->Void) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                completion("Client error!", nil)
                return
            }
            guard let mime = response?.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                completion("Wrong MIME type!", nil)
                return
            }
            do {
                guard let data = data else { return }
                if let _ = try? JSON(data: data) {
                    let (link, message) = self.parseJson(data: data)
                    completion(message,link)
                }
            }
        }.resume()
    }
    func parseJson(data: Data) -> (url:URL?,str:String) {
        var url: URL?
        var str = "parsed"
        if let json = try? JSON(data: data) {
            url = json["results"][0]["urls"]["thumb"].url ?? nil
            if url == nil { str = "invalid json" }
        }
        return (url:url,str:str)
    }
}
