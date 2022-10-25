//
//  RecordStorage.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 25.10.2022.
//

import Foundation
import FirebaseDatabase

protocol RecordStorageProtocol {
    func loadRecord() -> [RecordProtocol]
    func saveRecord(_ record: [RecordProtocol])
}

class RecordStorage: RecordStorageProtocol {
    
    private var storage = UserDefaults.standard
    
    var storageKey: String = "records"
    
    private enum RecordKey: String {
        case nameClient
        case numberPhone
        case date
        case time
    }
    
    func loadRecord() -> [RecordProtocol] {
        let formatter = DateFormatter()
        var resultRecord: [RecordProtocol] = []
        let recordFromStorage = storage.array(forKey: storageKey) as? [[String:String]] ?? []
        for record in recordFromStorage {
            guard let nameClient = record[RecordKey.nameClient.rawValue],
                  let numberPhone = record[RecordKey.numberPhone.rawValue],
                  let date = formatter.date(from: record[RecordKey.date.rawValue] ?? ""),
                  let time = record[RecordKey.time.rawValue] else {
                      continue
                  }
            resultRecord.append(RecordModel(nameClient: nameClient, numberPhone: numberPhone, date: date, time: time))
        }
        return resultRecord
    }
    
    func saveRecord(_ records: [RecordProtocol]) {
        var arrayForStorage: [[String:Any]] = []
        records.forEach { record in
            var newElementForStorage: Dictionary<String, Any> = [:]
            newElementForStorage[RecordKey.nameClient.rawValue] = record.nameClient
            newElementForStorage[RecordKey.numberPhone.rawValue] = record.numberPhone
            newElementForStorage[RecordKey.date.rawValue] = record.date
            newElementForStorage[RecordKey.time.rawValue] = record.time

            arrayForStorage.append(newElementForStorage)
        }
        storage.set(arrayForStorage, forKey: storageKey)
    }
}
