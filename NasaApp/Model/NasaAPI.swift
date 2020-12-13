//
//  NasaModel.swift
//  NasaApp
//
//  Created by Анастасия Улитина on 09.12.2020.
//

import Foundation

struct NasaAPI: Decodable {
    let collection: Items
}

struct Items: Decodable {
    let items: [NasaItem]
    let metadata: TotalHits
}

struct NasaItem: Decodable {
    let data: [Detail]
    let links: [Ref]
}

struct Detail: Decodable {
    let title: String?
    let media_type: String
    let date_created: String?
    let description: String?
}

struct Ref: Decodable {
    let href: String
}

struct TotalHits: Decodable {
    let total_hits: Int
}
