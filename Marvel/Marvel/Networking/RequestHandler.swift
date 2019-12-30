//
//  RequestHandler.swift
//  Marvel
//
//  Created by Mohamed Mahmoud Zaki on 12/26/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class RequestHandler {

    class func request(offset: Int, completion:((DataSource?, Error?) -> Void)?) {
        var urlComponent = URLComponents(string: Constants.baseURL + Constants.endPoint)
        urlComponent?.queryItems = query(offset: offset, limit: 5)
        guard let url = urlComponent?.url else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion?(nil, error)
                return
            }
            var user: DataSource?
                if let data = data {
                    do {
                    user = try JSONDecoder().decode(DataSource.self, from: data)
                        completion?(user,nil)
                    }
                    catch {
                        print("error")
                    }
                }
        }.resume()
    }

    private class func query(offset: Int = 0, limit: Int = 10) -> [URLQueryItem] {
        let timeStamp = Int(Date().timeIntervalSinceNow)
        let query1 = URLQueryItem(name: "ts", value: String(timeStamp))
        let query2 = URLQueryItem(name: "apikey", value: Constants.publicKey)
        let md5 = String(timeStamp) + Constants.privateKey + Constants.publicKey
        let query3 = URLQueryItem(name: "hash", value: md5.MD5())
        let offsetQuery = URLQueryItem(name: "offset", value: String(offset))
        let limitQuery = URLQueryItem(name: "limit", value: String(limit))
        return [query1, query2, query3, offsetQuery, limitQuery]
    }
}
