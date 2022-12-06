//
//  CountryView.swift
//  countries
//
//  Created by Ricardo Granja Chávez on 02/12/22.
//

import SwiftUI
import CoreLocation

struct CountryView: View {
    var country: CountryResponse
    
    var body: some View {
        List {
            Section {
                HStack(alignment: .center, spacing: 10.0) {
                    AsyncImage(
                        url: URL(string: self.country.flags.png),
                        content: { (image) in
                            image
                                .resizable()
                                .frame(width: 110, height: 65)
                                .border(.black, width: 0.5)
                        },
                        placeholder: {
                            ProgressView()
                                .frame(width: 110, height: 65)
                        }
                    )
                    
                    VStack(alignment: .leading) {
                        Text(self.country.name)
                            .font(Font.system(size: 20))
                            .bold()
                        if let capital = self.country.capital {
                            Text(capital)
                        }
                    }
                }
                
                HStack {
                    Text("Native name")
                    Spacer()
                    Text(self.country.nativeName)
                }
                
                if let altSpellings = self.country.altSpellings {
                    HStack(alignment: .top) {
                        Text("Alternative spellings")
                        Spacer()
                        Text(altSpellings.joined(separator: "\n"))
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            
            Section {
                if let latlng = self.country.latlng {
                    NavigationLink(destination: MapView(annotationItem: City(name: self.country.name,
                                                                             coordinate: CLLocationCoordinate2D(latitude: latlng[0],
                                                                                                                longitude: latlng[1])))) {
                        HStack(alignment: .top) {
                            Text("Position")
                            Spacer()
                            Text(self.getPosition(latlng: latlng))
                        }
                    }
                }
                
                HStack {
                    Text("Region")
                    Spacer()
                    Text(self.country.region)
                }
                
                HStack {
                    Text("Subregion")
                    Spacer()
                    Text(self.country.subregion)
                }
                
                HStack {
                    Text("Demonym")
                    Spacer()
                    Text(self.country.demonym)
                }
                
                HStack {
                    Text("Population")
                    Spacer()
                    Text(self.country.population.description)
                }
                
                if let area = self.country.area {
                    HStack(alignment: .top) {
                        Text("Area")
                        Spacer()
                        Text("\(String(format: "%.1f", area)) km²")
                    }
                }
                
                HStack(alignment: .top) {
                    Text("Languages")
                    Spacer()
                    Text(self.country.languages.map({ $0.name }).joined(separator: "\n"))
                        .multilineTextAlignment(.trailing)
                }
                
                if let borders = self.country.borders {
                    HStack(alignment: .top) {
                        Text("Borders")
                        Spacer()
                        Text(borders.joined(separator: "\n"))
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            
            if let currencies = self.country.currencies {
                Section("Currencies") {
                    HStack(alignment: .top) {
                        Text("Currency")
                        Spacer()
                        Text(currencies.map({ "\($0.name) (\($0.symbol), \($0.code))" }).joined(separator: "\n"))
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            
            Section("ISO code") {
                HStack(alignment: .top) {
                    Text("Numeric code")
                    Spacer()
                    Text(self.country.numericCode)
                }
                
                HStack(alignment: .top) {
                    Text("Alpha 2 Code")
                    Spacer()
                    Text(self.country.alpha2Code)
                }
                
                HStack(alignment: .top) {
                    Text("Alpha 3 Code")
                    Spacer()
                    Text(self.country.alpha3Code)
                }
            }
            
            Section {
                HStack(alignment: .top) {
                    Text("Time zones")
                    Spacer()
                    Text(self.country.timezones.joined(separator: "\n"))
                        .multilineTextAlignment(.trailing)
                }
            }
            
            Section {
                HStack(alignment: .top) {
                    Text("Top Level Domain")
                    Spacer()
                    Text(self.country.topLevelDomain.joined(separator: "\n"))
                        .multilineTextAlignment(.trailing)
                }
                
                HStack(alignment: .top) {
                    Text("Calling Codes")
                    Spacer()
                    Text(self.country.callingCodes.joined(separator: "\n"))
                        .multilineTextAlignment(.trailing)
                }
            }
            
            Section {
                HStack(alignment: .top) {
                    Text("Independent")
                    Spacer()
                    Text(self.country.independent ? "Yes" : "No")
                }
                
                if let cioc = self.country.cioc {
                    HStack(alignment: .top) {
                        Text("Cioc")
                        Spacer()
                        Text(cioc)
                    }
                }
                
                if let gini = self.country.gini {
                    HStack(alignment: .top) {
                        Text("Gini")
                        Spacer()
                        Text(gini.description)
                    }
                }
            }
            
            Section("Translations") {
                ForEach(0..<self.getTranslations(translation: self.country.translations).count, id: \.self) { (index) in
                    HStack(alignment: .top) {
                        Text(self.getTranslations(translation: self.country.translations)[index].title)
                        Spacer()
                        Text(self.getTranslations(translation: self.country.translations)[index].value)
                    }
                }
            }
            
            if let regionalBlocs = self.country.regionalBlocs {
                Section("Regional blocs") {
                    ForEach(0..<regionalBlocs.count, id: \.self) { (index) in
                        HStack(alignment: .top) {
                            Text(regionalBlocs[index].acronym)
                            Spacer()
                            Text(regionalBlocs[index].name)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
            }
        }
        .navigationTitle(self.country.name)
    }
    
    private func getPosition(latlng: [Double]) -> String {
        let latValue = latlng[0]
        let lngValue = latlng[1]
        let location = CLLocation(latitude: latValue, longitude: lngValue)
        
        return location.dms
    }
    
    private func getTranslations(translation: TranslationsResponse) -> [(title: String, value: String)] {
        var translationsTuple = [(title: "br", value: translation.br),
                                 (title: "de", value: translation.de),
                                 (title: "es", value: translation.es),
                                 (title: "fr", value: translation.fr),
                                 (title: "hr", value: translation.hr),
                                 (title: "hu", value: translation.hu),
                                 (title: "it", value: translation.it),
                                 (title: "ja", value: translation.ja),
                                 (title: "nl", value: translation.nl),
                                 (title: "pt", value: translation.pt),]
        
        if let fa = translation.fa {
            translationsTuple.insert((title: "fa", value: fa), at: 3)
        }
        return translationsTuple
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(country: Utils.country)
    }
}
