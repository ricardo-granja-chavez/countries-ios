//
//  Utils.swift
//  countries
//
//  Created by Ricardo Granja Chávez on 02/12/22.
//

import Foundation
import CoreLocation

class Utils {
    static let country: CountryResponse = CountryResponse(name: "Mexico",
                                                       topLevelDomain: [".mx"],
                                                       alpha2Code: "MX",
                                                       alpha3Code: "MEX",
                                                       callingCodes: ["52"],
                                                       capital: "Mexico City",
                                                       altSpellings: ["MX",
                                                                      "Mexicanos",
                                                                      "United Mexican States",
                                                                      "Estados Unidos Mexicanos"],
                                                       subregion: "North America",
                                                       region: "Americas",
                                                       population: 128932753,
                                                       latlng: [23.0,
                                                                -102.0],
                                                       demonym: "Mexican",
                                                       area: 1964375.0,
                                                       timezones: ["UTC-08:00",
                                                                   "UTC-07:00",
                                                                   "UTC-06:00"],
                                                       borders: ["BLZ",
                                                                 "GTM",
                                                                 "USA"],
                                                       nativeName: "MÃ©xico",
                                                       numericCode: "484",
                                                       flags: FlagsResponse(svg: "https://flagcdn.com/mx.svg",
                                                                            png: "https://flagcdn.com/w320/mx.png"),
                                                       currencies: [CurrencyResponse(code: "MXN",
                                                                                     name: "Mexican peso",
                                                                                     symbol: "$")],
                                                       languages: [LanguageResponse(iso6391: "es",
                                                                                    iso6392: "spa",
                                                                                    name: "Spanish",
                                                                                    nativeName: "EspaÃ±ol")],
                                                       translations: TranslationsResponse(br: "Mec'hiko",
                                                                                          pt: "MÃ©xico",
                                                                                          nl: "Mexico",
                                                                                          hr: "Meksiko",
                                                                                          fa: "Ù…Ú©Ø²ÛŒÚ©",
                                                                                          de: "Mexiko",
                                                                                          es: "MÃ©xico",
                                                                                          fr: "Mexique",
                                                                                          ja: "ãƒ¡ã‚­ã‚·ã‚³",
                                                                                          it: "Messico",
                                                                                          hu: "MexikÃ³"),
                                                       flag: "https://flagcdn.com/mx.svg",
                                                       regionalBlocs: [RegionalBlocResponse(acronym: "PA",
                                                                                            name: "Pacific Alliance",
                                                                                            otherNames: ["Alianza del PacÃ­fico"],
                                                                                            otherAcronyms: nil),
                                                                       RegionalBlocResponse(acronym: "NAFTA",
                                                                                            name: "North American Free Trade Agreement",
                                                                                            otherNames: ["Tratado de Libre Comercio de AmÃ©rica del Norte",
                                                                                                         "Accord de Libre-Ã©change Nord-AmÃ©ricain"],
                                                                                            otherAcronyms: nil),],
                                                       cioc: "MEX",
                                                       independent: true,
                                                       gini: 45.4)
}

extension BinaryFloatingPoint {
    var dms: (degrees: Int, minutes: Int, seconds: Int) {
        var seconds = Int(self * 3600)
        let degrees = seconds / 3600
        seconds = abs(seconds % 3600)
        return (degrees, seconds / 60, seconds % 60)
    }
}

extension CLLocation {
    var dms: String { self.latitude + " " + self.longitude }
    var latitude: String {
        let (degrees, minutes, seconds) = self.coordinate.latitude.dms
        return String(format: "%d°%d'%d\"%@", abs(degrees), minutes, seconds, degrees >= 0 ? "N" : "S")
    }
    var longitude: String {
        let (degrees, minutes, seconds) = self.coordinate.longitude.dms
        return String(format: "%d°%d'%d\"%@", abs(degrees), minutes, seconds, degrees >= 0 ? "E" : "W")
    }
}
