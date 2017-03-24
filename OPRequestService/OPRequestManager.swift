//
//  OPRequestManager.swift
//  OrlandoParking
//
//  Created by Keli'i Martin on 3/23/17.
//  Copyright © 2017 WERUreo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private let baseURL = "https://api.seatgeek.com/2"
private let eventsRequest = "\(baseURL)/events"

public typealias OPRequestEventsComplete = (_ events: [OPEvent]?, _ error: Error?) -> Void

public struct OPRequestManager
{
    ////////////////////////////////////////////////////////////
    // MARK: - Error Enum
    ////////////////////////////////////////////////////////////

    public enum OPRequestError : Error
    {
        case noAPIKey
        case requestFailed
        case invalidResponse

        public var localizedDescription: String
        {
            switch self
            {
                case .noAPIKey:         return "There was a problem retrieving the API key for SeatGeek"
                case .requestFailed:    return "The GET request failed."
                case .invalidResponse:  return "There was an invalid response."
            }
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    public static let shared = OPRequestManager()

    ////////////////////////////////////////////////////////////
    // MARK: - Initializer
    ////////////////////////////////////////////////////////////

    private init() {}

    ////////////////////////////////////////////////////////////
    // MARK: - Request Functions
    ////////////////////////////////////////////////////////////

    public func getEvents(_ completion: @escaping OPRequestEventsComplete)
    {
        guard let apiKey = SEATGEEK_KEY else
        {
            completion(nil, OPRequestError.noAPIKey)
            return
        }

        let parameters =
        [
            "client_id" : apiKey,
            "venue.id" : "3721,2652",
            "datetime_local.gte" : Date().dateString(),
            "datetime_local.lt" : Date().adding(.day, value: 1).dateString()
        ]

        Alamofire.request(eventsRequest, method: .get, parameters: parameters).validate().responseJSON()
        { response in
            if response.result.isSuccess
            {
                guard let value = response.result.value else
                {
                    let error = OPRequestError.invalidResponse
                    completion(nil, error)
                    return
                }

                var events = [OPEvent]()
                let json = JSON(value)
                for (_, subJSON) in json["events"]
                {
                    let event = OPEvent(json: subJSON)
                    events.append(event)
                }

                completion(events, nil)
            }
            else
            {
                completion(nil, response.result.error)
            }
        }
    }
}
