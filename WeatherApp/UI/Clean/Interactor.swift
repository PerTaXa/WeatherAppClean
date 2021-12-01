//
//  Interactor.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 28.11.21.
//

import Foundation
import Alamofire

protocol Interactor {
    func parse<T: Decodable>(
        _ response: DataResponse<Data, AFError>,
        completion: @escaping (Swift.Result<T, Error>) -> ()
    )
}

extension Interactor {
    
    func parse<T: Decodable>(
        _ response: DataResponse<Data, AFError>,
        completion: @escaping (Swift.Result<T, Error>) -> ()
    ) {
        if let error = response.error {
            completion(.failure(error))
        } else if let data = response.data {
            do {
                let container = try JSONDecoder().decode(T.self, from: data)
                completion(.success(container))
            } catch {
                completion(.failure(error))
            }
        } else{
            completion(.failure(AFError.responseSerializationFailed(reason:AFError.ResponseSerializationFailureReason.inputFileNil)))
        }
    }
}
