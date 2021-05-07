//
//  M_DetailsData.swift
//
//  Created by Jenish S on 07/05/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct M_DetailsData: Codable {

  enum CodingKeys: String, CodingKey {
    case list
  }

  var list: [M_List]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    list = try container.decodeIfPresent([M_List].self, forKey: .list)
  }

}
