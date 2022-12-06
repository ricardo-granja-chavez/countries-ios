//
//  CountryServices.swift
//  countries
//
//  Created by Ricardo Granja Chávez on 01/12/22.
//

import Foundation

class CountryServices {
    func gatAll(completion: @escaping (Swift.Result<[CountryResponse], APIError>) -> Void) {
        APIManager.shared.request(urlRequest: CountryAPIRouter.getAll, completion: completion)
    }
}
