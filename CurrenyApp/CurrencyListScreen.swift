//
//  ContentView.swift
//  CurrenyApp
//
//  Created by mac on 15/09/25.
//

import SwiftUI


struct CurrencyListScreen: View {
    @StateObject private var viewModel: CurrencyViewModel
    @State private var amount: String = ""
    @State private var isConvertingToUZS = true
    
    init() {
        let service = CurrencyService()
        let repo = CurrencyRepository(service: service)
        _viewModel = StateObject(wrappedValue: CurrencyViewModel(repository: repo))
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(spacing: 12) {
                    HStack {
                        TextField("Miqdor", text: $amount)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        
                        Picker("", selection: $isConvertingToUZS) {
                            Text("USD → UZS").tag(true)
                            Text("UZS → USD").tag(false)
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    if let usdRate = viewModel.currencies.first(where: { $0.code == "USD" })?.rate,
                       let rate = Double(usdRate),
                       let value = Double(amount) {
                        
                        let result = isConvertingToUZS ? value * rate
                                                      : value / rate
                        
                        Text("Natija: \(String(format: "%.2f", result)) \(isConvertingToUZS ? "so'm" : "USD")")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                Divider()
                
                if viewModel.isLoading {
                    ProgressView("Yuklanmoqda...")
                } else if let error = viewModel.errorMessage {
                    Text("Xatolik: \(error)")
                } else {
                    List(viewModel.currencies, id: \.code) { currency in
                        HStack(spacing: 16) {
                            Image(systemName: "globe")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading) {
                                Text(currency.name)
                                    .font(.headline)
                                Text(currency.code)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Text(currency.rate)
                                .font(.headline)
                                .foregroundColor(.green)
                        }
                        .padding(.vertical, 6)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Valyuta Kurslari")
            .onAppear {
                viewModel.loadCurrencies()
            }
        }
    }
}
