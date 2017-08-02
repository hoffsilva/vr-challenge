//
//  Top.swift
//
//  Created by Hoff Henry Pereira da Silva on 01/08/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

class Top: Model {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let channels = "channels"
    static let game = "game"
    static let viewers = "viewers"
  }

  // MARK: Properties
  public var channels: Int?
  public var game: Game?
  public var viewers: Int?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }
    
    override init() {
        super.init()
    }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    super.init(json: json)
    channels = json[SerializationKeys.channels].int
    game = Game(json: json[SerializationKeys.game])
    viewers = json[SerializationKeys.viewers].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = channels { dictionary[SerializationKeys.channels] = value }
    if let value = game { dictionary[SerializationKeys.game] = value.dictionaryRepresentation() }
    if let value = viewers { dictionary[SerializationKeys.viewers] = value }
    return dictionary
  }

}
