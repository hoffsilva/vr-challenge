//
//  ResponseData.swift
//
//  Created by Hoff Henry Pereira da Silva on 01/08/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ResponseData: NSCoding {

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
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
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

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.error = aDecoder.decodeObject(forKey: SerializationKeys.error) as? String
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? Int
    self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(error, forKey: SerializationKeys.error)
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(message, forKey: SerializationKeys.message)
  }

}
