//
//  RecordModel.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 22.10.2022.
//

import Foundation

protocol RecordProtocol {
    var nameClient: String { get set }
    var numberPhone: String { get set }
    var date: Date { get set }
    var time: String { get set }
}

struct RecordModel: RecordProtocol {
    var nameClient: String
    var numberPhone: String
    var date: Date
    var time: String
}
