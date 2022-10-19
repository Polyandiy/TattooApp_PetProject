//
//  DataModel.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 16.10.2022.
//

import Foundation

class APIResponse: Codable {
    let images_results: [Result]
}

class Result: Codable {
    let position: Int
    let thumbnail: String
}
