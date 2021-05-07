//
//  M_Option.swift
//
//  Created by Jenish S on 07/05/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct M_Option: Codable {

  enum CodingKeys: String, CodingKey {
    case name
    case payablePrice
    case id
    case mrp
  }

  var name: String?
  var payablePrice: Int?
  var id: Int?
  var mrp: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    payablePrice = try container.decodeIfPresent(Int.self, forKey: .payablePrice)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    mrp = try container.decodeIfPresent(Int.self, forKey: .mrp)
  }

}
