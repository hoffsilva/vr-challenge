//
//  Game.swift
//
//  Created by Hoff Henry Pereira da Silva on 01/08/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

class Game: Model {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let popularity = "popularity"
    static let id = "_id"
    static let box = "box"
    static let giantbombId = "giantbomb_id"
    static let localizedName = "localized_name"
    static let links = "_links"
    static let logo = "logo"
    static let locale = "locale"
  }

  // MARK: Properties
  public var name: String?
  public var popularity: Int?
  public var id: Int?
  public var giantbombId: Int?
  public var localizedName: String?
  public var locale: String?
  public var coverURL: String?

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
    name = json[SerializationKeys.name].string
    popularity = json[SerializationKeys.popularity].int
    id = json[SerializationKeys.id].int
    giantbombId = json[SerializationKeys.giantbombId].int
    localizedName = json[SerializationKeys.localizedName].string
    locale = json[SerializationKeys.locale].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = popularity { dictionary[SerializationKeys.popularity] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = giantbombId { dictionary[SerializationKeys.giantbombId] = value }
    if let value = localizedName { dictionary[SerializationKeys.localizedName] = value }
    if let value = locale { dictionary[SerializationKeys.locale] = value }
    return dictionary
  }

}
