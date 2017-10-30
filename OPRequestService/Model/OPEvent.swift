//
//  OPEvent.swift
//  OrlandoParking
//
//  Created by Keli'i Martin on 3/23/17.
//  Copyright © 2017 WERUreo. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct OPEvent
{
    public let title: String
    public let venueName: String
    public let time: Date
    
    enum CodingKeys: String, CodingKey
    {
        case title
        case venue
        case time = "datetime_local"
    }
    
    enum AdditionalInfoKeys: String, CodingKey
    {
        case name
    }
    
    init(json: JSON)
    {
        self.title = json["title"].stringValue
        self.venueName = json["venue"]["name"].stringValue
        self.time = Date(iso8601String: json["datetime_local"].stringValue)
    }
}

extension OPEvent: Decodable
{
    public init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try values.decode(String.self, forKey: .title)
        self.time = try Date(iso8601String: values.decode(String.self, forKey: .time))
        
        let additionalInfo = try values.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .venue)
        self.venueName = try additionalInfo.decode(String.self, forKey: .name)
    }
}
