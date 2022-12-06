//
//  APIManager.swift
//  countries
//
//  Created by Ricardo Granja Chávez on 01/12/22.
//

import UIKit
import Alamofire

class APIManager {
    public static var shared = APIManager()
    
    public var baseURL: String { "https://restcountries.com" }
    
//    public var headers: [String : String] {
//        guard let token = ValuesStorage.shared.token else { return [:] }
//        return ["Content-Type": "application/json",
//                "Accept": "application/json",
//                "Authorization": token]
//    }
    
    public var isReachable: Bool { NetworkReachabilityManager()?.isReachable ?? false }
    
    public func request<T: Codable>(urlRequest: APIConfiguration, completion: @escaping (Swift.Result<T, APIError>) -> Void) {
        debugPrint("❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️ [NEW REQUEST] ❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️")
        if let absoluteString = urlRequest.urlRequest?.url?.absoluteString { debugPrint("🔥[URL][\(urlRequest.method.rawValue.uppercased())]🔥: \(absoluteString)") }
        if let parameters = urlRequest.parameters { debugPrint("😡[PARAMETERS]😡: \(parameters)") }
        if !self.isReachable { completion(.failure(.notInternetConection)); return }
        
        Alamofire.request(urlRequest).responseData { [weak self] (response) in
            guard let self = self,
                  let statusCode = response.response?.statusCode else { completion(.failure(.badRequest)); return }
            
            debugPrint("🚧[STATUS CODE]🚧: \(statusCode)")
            self.printLogs(response)
            
            switch statusCode {
            case 200...299:
                guard let data = response.data else { completion(.failure(.jsonDecodingError)); return }
                guard data.count > 0 else {
                    if let emptyJson = "{}".data(using: .utf8), let decodedObject = try? urlRequest.jsonDecoder.decode(T.self, from: emptyJson) {
                        completion(.success(decodedObject))
                    }
                    return
                }
                do {
                    let decodedObject = try urlRequest.jsonDecoder.decode(T.self, from: data)
                    completion(.success(decodedObject))
                    return
                } catch let error {
                    debugPrint("JSON decode error: \(error.localizedDescription)")
                    completion(.failure(.jsonDecodingError))
                    return
                }
            default:
                completion(.failure(.badRequest))
                return
            }
        }
    }
    
//    public func upload<T: Codable>(urlRequest: APIConfiguration, multipartForms: [MultipartModel], completion: @escaping (Swift.Result<T, APIError> ) -> Void) {
//        if !self.isReachable { completion(.failure(.notInternetConection)); return }
//
//        Alamofire.upload(multipartFormData: { (multipart) in
//            if let params = urlRequest.parameters {
//                for (key, value) in params {
//                    let valueString = "\(value)"
//                    guard let data = valueString.data(using: .utf8) else {continue}
//                    multipart.append(data, withName: key)
//                }
//            }
//
//            for model in multipartForms {
//                multipart.append(model.url, withName: model.key)
//            }
//        }, with: urlRequest) { [weak self] (encodingResult) in
//            guard let self = self else { return }
//
//            switch encodingResult {
//            case .success(let upload, _, _):
//                upload.responseData { response in
//                    guard let statusCode = response.response?.statusCode else { completion(.failure(.badRequest)); return }
//
//                    debugPrint("🚧[STATUS CODE]🚧: \(statusCode)")
//                    self.printLogs(response)
//
//                    switch statusCode {
//                    case 200...299:
//                        guard let data = response.data else { completion(.failure(.jsonDecodingError)); return }
//                        guard data.count > 0 else {
//                            if let emptyJson = "{}".data(using: .utf8), let decodedObject = try? urlRequest.jsonDecoder.decode(T.self, from: emptyJson) {
//                                completion(.success(decodedObject))
//                            }
//                            return
//                        }
//                        do {
//                            let decodedObject = try urlRequest.jsonDecoder.decode(T.self, from: data)
//                            completion(.success(decodedObject))
//                            return
//                        } catch let error {
//                            debugPrint("JSON decode error: \(error.localizedDescription)")
//                            completion(.failure(.jsonDecodingError))
//                            return
//                        }
//                    case 400...499:
//                        //guard let data = response.data else { completion(.failure(.jsonDecodingError)); return }
//                        //do {
//                        //    let decodedObject: ErrorModel = try urlRequest.jsonDecoder.decode(ErrorModel.self, from: data)
//                        //    completion(.failure(.responseErrorMessage(message: decodedObject.error)))
//                        //} catch {
//                        //    debugPrint("JSON decode error: \(error)")
//                        //    completion(.failure(.jsonDecodingError))
//                        //}
//                        completion(.failure(.badRequest))
//                        return
//                    default:
//                        completion(.failure(.badRequest))
//                        return
//                    }
//                }
//            case .failure(let encodingError):
//                print(encodingError)
//            }
//        }
//    }
//    public func requestData(urlRequest: APIConfiguration, completion: @escaping (Swift.Result<Data, APIError>) -> Void) {
//        debugPrint("❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️ [NEW REQUEST] ❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️")
//        if let absoluteString = urlRequest.urlRequest?.url?.absoluteString { debugPrint("🔥[URL][\(urlRequest.method.rawValue.uppercased())]🔥: \(absoluteString)") }
//        if let parameters = urlRequest.parameters { debugPrint("😡[PARAMETERS]😡: \(parameters)") }
//        if !self.isReachable { completion(.failure(.notInternetConection)); return }
//        
//        Alamofire.request(urlRequest).responseData { [weak self] (response) in
//            guard let self = self,
//                  let statusCode = response.response?.statusCode else { completion(.failure(.badRequest)); return }
//            
//            debugPrint("🚧[STATUS CODE]🚧: \(statusCode)")
//            self.printLogs(response)
//            
//            switch statusCode {
//            case 200...299:
//                guard let data = response.data else { completion(.failure(.badRequest)); return }
//                
//                if data.count > 0 {
//                    completion(.success(data))
//                }else{
//                    completion(.failure(.badRequest))
//                }
//                
//
//            case 400...499:
//                //guard let data = response.data else { completion(.failure(.jsonDecodingError)); return }
//                //do {
//                //    let decodedObject: ErrorModel = try urlRequest.jsonDecoder.decode(ErrorModel.self, from: data)
//                //    completion(.failure(.responseErrorMessage(message: decodedObject.error)))
//                //} catch {
//                //    debugPrint("JSON decode error: \(error)")
//                //    completion(.failure(.jsonDecodingError))
//                //}
//                completion(.failure(.badRequest))
//                return
//            default:
//                completion(.failure(.badRequest))
//                return
//            }
//        }
//    }

    public func printLogs(_ response: DataResponse<Data>) {
        if let response = response.response {
            debugPrint("🚘[Response]🚘: \(response)")
        }
        if let request = response.request, let httpBody = request.httpBody, let requestParameters = String(data: httpBody, encoding: .utf8) {
            debugPrint("⚠️[Request]⚠️: \(requestParameters)")
        }
        if let data = response.data, let returnData = String(data: data, encoding: .utf8) {
            debugPrint("🚨[Result]🚨: \(returnData)")
        }
    }
}

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var encoding: ParameterEncoding { get }
    var parameters: Parameters? { get }
    var jsonDecoder: JSONDecoder { get }
}

extension APIConfiguration {
    var jsonDecoder: JSONDecoder {
        get {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            return jsonDecoder
        }
    }
}

enum APIError: Error {
    case jsonDecodingError
    case badRequest
    case responseErrorMessage(message: String)
    case notInternetConection
    case multipartEncodingError
}

enum APIVersion : String {
    case second = "/v2"
}
