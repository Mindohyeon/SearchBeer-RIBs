//
//  RootModel.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/29.
//

import Foundation

struct BeerModel: Codable {
    let id: Int
    let name, description, imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case imageUrl = "image_url"
    }
}
