//
//  CurrencyProtocol.swift
//  CurrenyApp
//
//  Created by mac on 15/09/25.
//

import Foundation

protocol CurrencyServiceProtocol {
    func fetchCurrencies(completion: @escaping (Result<[Currency], Error>) -> Void)
}

final class CurrencyService: CurrencyServiceProtocol {
    private let url = URL(string: "https://cbu.uz/uz/arkhiv-kursov-valyut/json/")!
    
    func fetchCurrencies(completion: @escaping (Result<[Currency], Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1)))
                return
            }
            do {
                let result = try JSONDecoder().decode([Currency].self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

