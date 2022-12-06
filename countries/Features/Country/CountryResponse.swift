//
//  CountryResponse.swift
//  countries
//
//  Created by Ricardo Granja Chávez on 01/12/22.
//

import Foundation

struct CountriesSection: Codable, Identifiable {
    let id: UUID
    let title: String
    var countries: [CountryResponse]
}

struct CountryResponse: Codable, Identifiable {
    var id: UUID?
    
    let name: String
    let topLevelDomain: [String]
    let alpha2Code, alpha3Code: String
    let callingCodes: [String]
    let capital: String?
    let altSpellings: [String]?
    let subregion: String
    let region: String
    let population: Int
    let latlng: [Double]?
    let demonym: String
    let area: Double?
    let timezones: [String]
    let borders: [String]?
    let nativeName, numericCode: String
    let flags: FlagsResponse
    let currencies: [CurrencyResponse]?
    let languages: [LanguageResponse]
    let translations: TranslationsResponse
    let flag: String
    let regionalBlocs: [RegionalBlocResponse]?
    let cioc: String?
    let independent: Bool
    let gini: Double?
}

// MARK: - Currency
struct CurrencyResponse: Codable {
    let code, name, symbol: String
}

// MARK: - Flags
struct FlagsResponse: Codable {
    let svg: String
    let png: String
}

// MARK: - Language
struct LanguageResponse: Codable {
    let iso6391: String?
    let iso6392: String?
    let name: String
    let nativeName: String?

    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso639_1"
        case iso6392 = "iso639_2"
        case name, nativeName
    }
}

enum RegionType: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case antarctic = "Antarctic"
    case antarcticOcean = "Antarctic Ocean"
    case asia = "Asia"
    case europe = "Europe"
    case oceania = "Oceania"
    case polar = "Polar"
}

// MARK: - RegionalBloc
struct RegionalBlocResponse: Codable {
    let acronym: String
    let name: String
    let otherNames: [String]?
    let otherAcronyms: [String]?
}

// MARK: - Translations
struct TranslationsResponse: Codable {
    let br, pt, nl, hr: String
    let fa: String?
    let de, es, fr, ja: String
    let it, hu: String
}
