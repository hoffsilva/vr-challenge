//
//  ResponseData.swift
//
//  Created by Hoff Henry Pereira da Silva on 01/08/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

class ResponseData: Model {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let error = "error"
    static let status = "status"
    static let message = "message"
  }

  // MARK: Properties
  public var error: String?
  public var status: Int?
  public var message: String?

  // MARK: SwiftyJSON Initializers
    

    override init() {
        super.init()
    }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  required init(json: JSON) {
    super.init(json: json)
    error = json[SerializationKeys.error].string
    status = json[SerializationKeys.status].int
    message = json[SerializationKeys.message].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = error { dictionary[SerializationKeys.error] = value }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = message { dictionary[SerializationKeys.message] = value }
    return dictionary
  }

}
