//
//  NetworkClient.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 11/11/18.
//  Copyright © 2018 Akash Rastogi. All rights reserved.
//

import Foundation


// MARK: - NetworkError

/// _NetworkError_ is an enumeration that specifies network errors
enum NetworkError: Error {

    case generic
    case invalidURL
}


// MARK: - NetworkClientProtocol

/// _NetworkClientProtocol_ is a protocol specifies send network requests behaviour
protocol NetworkClientProtocol {

    func sendRequest(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}


// MARK: - NetworkClient

/// _NetworkClient_ is a class responsible for network requests
class NetworkClient: NetworkClientProtocol {

    static let sharedInstance = NetworkClient()

    let session: URLSession!


    // MARK: - Initialisers

    /// Initializes an instance of _NetworkClient_
    ///
    /// - returns: The instance of _NetworkClient_
    init() {

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20.0

        session = URLSession(configuration: configuration)
    }


    // MARK: - Send requests

    /// Sends a URL request
    ///
    /// - parameter request:    The URL request
    /// - parameter completion: The completion block
    func sendRequest(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {

        guard let _ = request.url else {

            completion(nil, nil, NetworkError.invalidURL)
            return
        }
        
        session.dataTask(with: request) { data, response, error in

            DispatchQueue.main.async {

                completion(data, response, error)
            }

        }.resume()
    }
}
