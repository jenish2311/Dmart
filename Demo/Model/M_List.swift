//
//  M_List.swift
//
//  Created by Jenish S on 07/05/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct M_List: Codable {

  enum CodingKeys: String, CodingKey {
    case bannerImage
    case gridItem
    case listType
    case gridLength
  }

  var bannerImage: String?
  var gridItem: [M_GridItem]?
  var listType: Int?
  var gridLength: Int?
  var type : TypeOfList = .banner


  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    bannerImage = try container.decodeIfPresent(String.self, forKey: .bannerImage)
    gridItem = try container.decodeIfPresent([M_GridItem].self, forKey: .gridItem)
    listType = try container.decodeIfPresent(Int.self, forKey: .listType)
    gridLength = try container.decodeIfPresent(Int.self, forKey: .gridLength)
    type = TypeOfList(rawValue: listType ?? 1) ?? .banner
  }

}
