//
//  NetworkingService.swift
//  Places
//
//  Created by Christian Ampe on 5/16/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Moya

enum NetworkingService {
    case showUnsplashPhotos(query: String)
}

extension NetworkingService: TargetType {
    var baseURL: URL {
        switch self {
        case .showUnsplashPhotos:
            return URL(string: "https://api.unsplash.com/")!
        }
    }
    
    var path: String {
        switch self {
        case .showUnsplashPhotos:
            return "/search/photos"
        }
    }
    
    var method: Method {
        switch self {
        case .showUnsplashPhotos:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .showUnsplashPhotos:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .showUnsplashPhotos(let query):
            return .requestParameters(parameters: ["query": query,
                                                   "page": 1,
                                                   "per_page": 20,
                                                   "orientation": "squarish",
                                                   "client_id": "3d248a41fbbbd04205ab275c57c13c73b61a4f53435e188fcf06fd7bcc87a2e6"],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .showUnsplashPhotos:
            return ["Accept-Version": "v1"]
        }
    }
}

private enum NetworkingConstants {
    static let unsplashAccessKey = "3d248a41fbbbd04205ab275c57c13c73b61a4f53435e188fcf06fd7bcc87a2e6"
    static let unsplashSecretKey = "953fc03400282605590577210cb8c7b33a1c6fc1891fd515c032189ab757cfa8"
}
