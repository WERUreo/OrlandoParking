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

    init(json: JSON)
    {
        self.title = json["title"].stringValue
        self.venueName = json["venue"]["name"].stringValue
        self.time = Date(iso8601String: json["datetime_local"].stringValue)
    }
}
