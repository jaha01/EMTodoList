//
//  NetworkManager.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 10.04.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func request(completion: @escaping(Result<TodoResponse,Error>)->Void)
}

final class NetworkService : NSObject, NetworkServiceProtocol {
    private var networkConfiguration = NetworkConfig()
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)

    func request(completion: @escaping(Result<TodoResponse,Error>)->Void) {
        guard let url = URL(string: "\(networkConfiguration.url)") else {
            completion(.failure(CustomError(message: "Wrong uri")))
            return
        }
        
        let dataTask = urlSession.dataTask(with: URLRequest(url: url), completionHandler: { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<400:
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    do {
                        let toDoList = try jsonDecoder.decode(TodoResponse.self, from: data)
                        completion(.success(toDoList))
                    } catch {
                        completion(.failure(error))
                    }
                default:
                    completion(.failure(CustomError(message: "\(response.statusCode)")))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        })
        dataTask.resume()
    }
}
