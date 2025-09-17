//
//  CurrencyViewModel.swift
//  CurrenyApp
//
//  Created by mac on 15/09/25.
//

import Combine
import Foundation

final class CurrencyViewModel: ObservableObject {
    @Published var currencies: [Currency] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let repository: CurrencyRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: CurrencyRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadCurrencies() {
        isLoading = true
        repository.getCurrencies { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let data):
                    self?.currencies = data
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
