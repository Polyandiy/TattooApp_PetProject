//
//  DataModel.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 16.10.2022.
//

import Foundation

struct APIResponse: Codable {
    let images_results: [Result]
}

struct Result: Codable {
    let position: Int
    let thumbnail: String
}
