//
//  NetworkServices.swift
//  EarthQuakeViewer
//
//  Created by Cindy Bi on 3/30/17.
//  Copyright © 2017 Cindy Bi. All rights reserved.
//

import Foundation

public class DataFetcher{

    var onComplete: ((_ result: Data?, _ response: URLResponse?, _ error: Error?)->())?

    init() {
    }

    func requestData(with urlString: String) {
        let url = URL(string: urlString)
        guard url != nil else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url!)

        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            self.onComplete!(data, response, error)
        }
        task.resume()
    }
}
