//
//  InterfaceController.swift
//  OrlandoParkingWatch Extension
//
//  Created by Keli'i Martin on 3/23/17.
//  Copyright © 2017 WERUreo. All rights reserved.
//

import WatchKit
import Foundation
import OPRequestService

class InterfaceController: WKInterfaceController
{
    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    @IBOutlet var noEventsLabel: WKInterfaceLabel!
    @IBOutlet var table: WKInterfaceTable!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    var events = [OPEvent]()
    let requestManager = OPRequestManager.shared

    ////////////////////////////////////////////////////////////
    // MARK: - Interface Controller Lifecycle
    ////////////////////////////////////////////////////////////

    override func awake(withContext context: Any?)
    {
        super.awake(withContext: context)
    }

    ////////////////////////////////////////////////////////////
    
    override func willActivate()
    {
        super.willActivate()
        updateUI()
    }

    ////////////////////////////////////////////////////////////
    
    override func didDeactivate()
    {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    ////////////////////////////////////////////////////////////
    // MARK: -
    ////////////////////////////////////////////////////////////

    func updateUI()
    {
        print("I am in updateUI()")
        self.requestManager.getEvents
        { events, error in
            if let error = error
            {
                print(error.localizedDescription)
            }
            else
            {
                if let events = events
                {
                    self.events = events

                    if (self.events.count > 0)
                    {
                        self.noEventsLabel.setText("The following event(s) may trigger event parking:")
                        self.noEventsLabel.setVerticalAlignment(.top)
                        self.table.setHidden(false)
                        self.table.setNumberOfRows(self.events.count, withRowType: "EventRow")
                        for (index, event) in self.events.enumerated()
                        {
                            if let rowController = self.table.rowController(at: index) as? EventRowController
                            {
                                rowController.eventLabel.setText(event.title)
                                rowController.venueLabel.setText(event.venueName)
                                rowController.timeLabel.setText(event.time.dateString(withFormat: "h:mm a"))
                            }
                        }
                    }
                    else
                    {
                        self.noEventsLabel.setText("There doesn't appear to be any events that would trigger event parking.")
                        self.noEventsLabel.setVerticalAlignment(.center)
                        self.table.setHidden(true)
                    }
                }
            }
        }
    }
}
