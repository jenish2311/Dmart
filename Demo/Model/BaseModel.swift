//
//  BaseModel.swift
//
//  Created by Jenish S on 07/05/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct BaseModel<T: Codable>: Codable {

  enum CodingKeys: String, CodingKey {
    case result
    case status
    case message
  }
  var result: T?
  var status: String?
  var message: String?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    result = try container.decodeIfPresent(T.self, forKey: .result)
    status = try container.decodeIfPresent(String.self, forKey: .status)
    message = try container.decodeIfPresent(String.self, forKey: .message)
  }

}
public struct parsingManager<T:Codable> {
    
    public init(){}
    
    internal func parse(from response: Data) -> BaseModel<T>? {
        var parsedObject: BaseModel<T>!
        do {
            let decoder = JSONDecoder()
            let array = try decoder.decode(BaseModel<T>.self, from: response)
            parsedObject = array
        } catch let error{
            print(error)
        }
        return parsedObject
    }
}
