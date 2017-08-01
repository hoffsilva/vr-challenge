//
//  Game.swift
//
//  Created by Hoff Henry Pereira da Silva on 01/08/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Game: NSCoding {

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
  public var box: Box?
  public var giantbombId: Int?
  public var localizedName: String?
  public var links: Links?
  public var logo: Logo?
  public var locale: String?

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
    name = json[SerializationKeys.name].string
    popularity = json[SerializationKeys.popularity].int
    id = json[SerializationKeys.id].int
    box = Box(json: json[SerializationKeys.box])
    giantbombId = json[SerializationKeys.giantbombId].int
    localizedName = json[SerializationKeys.localizedName].string
    links = Links(json: json[SerializationKeys.links])
    logo = Logo(json: json[SerializationKeys.logo])
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
    if let value = box { dictionary[SerializationKeys.box] = value.dictionaryRepresentation() }
    if let value = giantbombId { dictionary[SerializationKeys.giantbombId] = value }
    if let value = localizedName { dictionary[SerializationKeys.localizedName] = value }
    if let value = links { dictionary[SerializationKeys.links] = value.dictionaryRepresentation() }
    if let value = logo { dictionary[SerializationKeys.logo] = value.dictionaryRepresentation() }
    if let value = locale { dictionary[SerializationKeys.locale] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.popularity = aDecoder.decodeObject(forKey: SerializationKeys.popularity) as? Int
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.box = aDecoder.decodeObject(forKey: SerializationKeys.box) as? Box
    self.giantbombId = aDecoder.decodeObject(forKey: SerializationKeys.giantbombId) as? Int
    self.localizedName = aDecoder.decodeObject(forKey: SerializationKeys.localizedName) as? String
    self.links = aDecoder.decodeObject(forKey: SerializationKeys.links) as? Links
    self.logo = aDecoder.decodeObject(forKey: SerializationKeys.logo) as? Logo
    self.locale = aDecoder.decodeObject(forKey: SerializationKeys.locale) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(popularity, forKey: SerializationKeys.popularity)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(box, forKey: SerializationKeys.box)
    aCoder.encode(giantbombId, forKey: SerializationKeys.giantbombId)
    aCoder.encode(localizedName, forKey: SerializationKeys.localizedName)
    aCoder.encode(links, forKey: SerializationKeys.links)
    aCoder.encode(logo, forKey: SerializationKeys.logo)
    aCoder.encode(locale, forKey: SerializationKeys.locale)
  }

}
