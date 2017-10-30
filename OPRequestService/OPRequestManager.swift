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

public final class OPRequestManager
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

    public enum EventInterval
    {
        case today, thisWeek
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    public static let shared = OPRequestManager()
    public var eventCount = 0
    lazy var sessionManager: Alamofire.SessionManager =
    {
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.werureo.backgroundSession")
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()

    ////////////////////////////////////////////////////////////
    // MARK: - Initializer
    ////////////////////////////////////////////////////////////

    private init() {}

    ////////////////////////////////////////////////////////////
    // MARK: - Request Functions
    ////////////////////////////////////////////////////////////

    public func getEvents(for interval: EventInterval = .today, _ completion: @escaping OPRequestEventsComplete)
    {
        print("Just entered getEvents()")
        guard let apiKey = SEATGEEK_KEY else
        {
            completion(nil, OPRequestError.noAPIKey)
            return
        }

//        let endDate = (interval == .today) ? Date().end(of: .day) : Date().end(of: .weekOfMonth)
        
        let parameters =
        [
            "client_id" : apiKey,
            "venue.id" : "3721,2652"/*,
            "datetime_local.gte" : Date().dateString(),
            "datetime_local.lt" : (endDate ?? Date()).dateString()*/
        ]
        
        print("About to send request")
        /*self.sessionManager*/Alamofire.request(eventsRequest, method: .get, parameters: parameters).validate().responseJSON
        { [weak self] response in
            print("trying to get response")
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

                self?.eventCount = events.count
                completion(events, nil)
            }
            else
            {
                completion(nil, response.result.error)
            }
        }
    }
}
