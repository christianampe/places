//
//  NetworkingProvider.swift
//  Places
//
//  Created by Christian Ampe on 5/16/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import Moya

protocol NetworkingProviderProtocol: class {
    static func fetchPhotos(of query: String,
                            _ completion: @escaping (Result<UnsplashSearchResponse, Error>) -> Void)
    
    static func fetchNationalParks(in state: String,
                                   _ completion: @escaping (Result<NPSParksReponse, Error>) -> Void)
}

final class NetworkingProvider: NetworkingProviderProtocol {
    private static let provider = MoyaProvider<NetworkingService>()
    private static let jsonDecoder = JSONDecoder()
}

extension NetworkingProvider {
    static func fetchPhotos(of query: String,
                            _ completion: @escaping (Result<UnsplashSearchResponse, Error>) -> Void) {
        
        provider.request(.getUnsplashPhotos(query: query)) { result in
            switch result {
            case .success(let moyaResponse):
                do {
                    completion(.success(try jsonDecoder.decode(UnsplashSearchResponse.self,
                                                               from: moyaResponse.data)))
                } catch {
                    completion(.failure(NetworkingError()))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func fetchNationalParks(in state: String,
                                   _ completion: @escaping (Result<NPSParksReponse, Error>) -> Void) {
        
        provider.request(.getNationalParks(state: state)) { result in
            switch result {
            case .success(let moyaResponse):
                do {
                    completion(.success(try jsonDecoder.decode(NPSParksReponse.self,
                                                               from: moyaResponse.data)))
                } catch {
                    completion(.failure(NetworkingError()))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
