//
//  M_GridItem.swift
//
//  Created by Jenish S on 07/05/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct M_GridItem: Codable {

  enum CodingKeys: String, CodingKey {
    case name
    case id
    case option
    case image
  }

  var name: String?
  var id: Int?
  var option: [M_Option]?
  var image: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    option = try container.decodeIfPresent([M_Option].self, forKey: .option)
    image = try container.decodeIfPresent(String.self, forKey: .image)
  }

}
