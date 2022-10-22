//
//  RecordModel.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 22.10.2022.
//

import Foundation

enum RecordStatus {
    case free
    case engaged
}

struct RecordModel {
    var nameClient: String
    var numberPhone: String
    var date: Date
    var status: RecordStatus
}
