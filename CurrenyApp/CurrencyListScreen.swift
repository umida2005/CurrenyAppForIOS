//
//  ContentView.swift
//  CurrenyApp
//
//  Created by mac on 15/09/25.
//

import SwiftUI


struct CurrencyListScreen: View {
    @StateObject private var viewModel: CurrencyViewModel
    
    init() {
        let service = CurrencyService()
        let repo = CurrencyRepository(service: service)
        _viewModel = StateObject(wrappedValue: CurrencyViewModel(repository: repo))
    }
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Yuklanmoqda...")
                } else if let error = viewModel.errorMessage {
                    Text("Xatolik: \(error)")
                } else {
                    List(viewModel.currencies, id: \.code) { currency in
                        HStack {
                            Image("globus ")
                            Text(currency.name)
                            Spacer()
                            Text(currency.rate)
                        }
                    }
                }
            }
            .navigationTitle("Valyuta Kurslari")
        }
        .onAppear {
            viewModel.loadCurrencies()
        }
    }
}

