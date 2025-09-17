//
//  CurrencyRepository.swift
//  CurrenyApp
//
//  Created by mac on 15/09/25.
//
import Foundation

protocol CurrencyRepositoryProtocol {
    func getCurrencies(completion: @escaping (Result<[Currency], Error>) -> Void)
}

final class CurrencyRepository: CurrencyRepositoryProtocol {
    private let service: CurrencyServiceProtocol
    
    init(service: CurrencyServiceProtocol) {
        self.service = service
    }
    
    func getCurrencies(completion: @escaping (Result<[Currency], Error>) -> Void) {
        service.fetchCurrencies(completion: completion)
    }
}
