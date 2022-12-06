//
//  CountriesView.swift
//  countries
//
//  Created by Ricardo Granja Chávez on 01/12/22.
//

import SwiftUI

struct CountriesView: View {
    @StateObject var viewModel = CountriesListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.countries) { (section) in
                Section {
                    ForEach(section.countries) { (country) in
                        NavigationLink(destination: CountryView(country: country)) {
                            HStack(alignment: .center, spacing: 10.0) {
                                AsyncImage(
                                    url: URL(string: country.flags.png),
                                    content: { (image) in
                                        image
                                            .resizable()
                                            .frame(width: 50, height: 30)
                                            .border(.black, width: 0.5)
                                    },
                                    placeholder: {
                                        ProgressView()
                                            .frame(width: 50, height: 30)
                                    }
                                )
                                
                                Text(country.name)
                            }
                        }
                    }
                } header: {
                    Text(section.title)
                        .font(Font.system(size: 22))
                        .bold()
                }
            }
            .navigationTitle("Countries")
            .listStyle(.sidebar)
        }
        .onAppear {
            viewModel.getAll()
        }
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView()
    }
}
