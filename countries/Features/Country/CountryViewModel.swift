//
//  CountryViewModel.swift
//  countries
//
//  Created by Ricardo Granja Chávez on 01/12/22.
//

import Foundation

class CountryViewModel: ObservableObject {}

class CountriesListViewModel: ObservableObject {
    @Published var countries: [CountriesSection] = []
    @Published var isLoading: Bool = false
    @Published var haveError: Bool = false
    
    private let services = CountryServices()
    
    func getAll() {
        self.isLoading = true
        self.services.gatAll { (result) in
            self.isLoading = false
            
            switch result {
            case .success(let data):
                let sortData = data.sorted(by: { $0.name < $1.name })
                var newCountries: [CountriesSection] = []
                self.countries.removeAll()
                
                for country in sortData {        
                    let key = country.name.prefix(1).description
                    let upper = key.uppercased()
                    var newCountry = country
                    newCountry.id = UUID()
                    
                    if let index = newCountries.firstIndex(where: { $0.title.uppercased() == upper }) {
                        newCountries[index].countries.append(newCountry)
                    } else {
                        newCountries.append(CountriesSection(id: UUID(), title: upper, countries: [newCountry]))
                    }
                }
                self.countries = newCountries
            case .failure:
                self.haveError = true
            }
        }
    }
}
