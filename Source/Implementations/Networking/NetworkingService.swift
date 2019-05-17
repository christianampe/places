//
//  NetworkingService.swift
//  Places
//
//  Created by Christian Ampe on 5/16/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Moya

enum NetworkingService {
    
    /// https://unsplash.com/documentation#search-photos
    case getUnsplashPhotos(query: String)
    
    /// https://www.nps.gov/subjects/developer/api-documentation.htm#/parks/getPark
    case getNationalParks(state: String)
}

extension NetworkingService: TargetType {
    var baseURL: URL {
        switch self {
        case .getUnsplashPhotos:
            return URL(string: "https://api.unsplash.com/")!
        case .getNationalParks:
            return URL(string: "https://developer.nps.gov/api/v1")!
        }
    }
    
    var path: String {
        switch self {
        case .getUnsplashPhotos:
            return "/search/photos"
        case .getNationalParks:
            return "/parks"
        }
    }
    
    var method: Method {
        switch self {
        case .getUnsplashPhotos:
            return .get
        case .getNationalParks:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getUnsplashPhotos(let query):
            return .requestParameters(parameters: ["query": query,
                                                   "page": 1,
                                                   "per_page": 20,
                                                   "orientation": "squarish",
                                                   "client_id": "3d248a41fbbbd04205ab275c57c13c73b61a4f53435e188fcf06fd7bcc87a2e6"],
                                      encoding: URLEncoding.queryString)
        case .getNationalParks(let state):
            return .requestParameters(parameters: ["stateCode": state,
                                                   "limit": 8,
                                                   "fields": "images",
                                                   "api_key": "Fc68gOahpFrcSpaocyUYEZDme5QXV54ZKOQnElOH"],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getUnsplashPhotos:
            return ["Accept-Version": "v1"]
        case .getNationalParks:
            return nil
        }
    }
}

private enum NetworkingConstants {
    static let unsplashAccessKey = "3d248a41fbbbd04205ab275c57c13c73b61a4f53435e188fcf06fd7bcc87a2e6"
    static let unsplashSecretKey = "953fc03400282605590577210cb8c7b33a1c6fc1891fd515c032189ab757cfa8"   
    static let npsAPIKey = "Fc68gOahpFrcSpaocyUYEZDme5QXV54ZKOQnElOH"
}
