//
//  CountryAPIRouter.swift
//  countries
//
//  Created by Ricardo Granja Chávez on 01/12/22.
//

import Alamofire

enum CountryAPIRouter: APIConfiguration {
    case getAll
    
    var method: HTTPMethod {
        switch self {
        case .getAll:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getAll:
            return "/all"
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getAll:
            return JSONEncoding.default
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getAll:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlString = APIManager.shared.baseURL + APIVersion.second.rawValue + self.path
        let urlEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""
        var urlRequest = try URLRequest(url: urlEncoded, method: self.method)
        urlRequest = try encoding.encode(urlRequest, with: self.parameters)
        return urlRequest
    }
}
