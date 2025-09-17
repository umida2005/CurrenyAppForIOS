//
//  Currency.swift
//  CurrenyApp
//
//  Created by mac on 15/09/25.
//
import Foundation

struct Currency : Codable {
    let code : String
    let name : String
    let rate : String
    let date : String
    
    
    enum CodingKeys : String, CodingKey{
        case code = "Ccy"
        case name = "CcyNm_UZ"
        case rate = "Rate"
        case date = "Date"
    }
}
