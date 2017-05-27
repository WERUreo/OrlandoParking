//
//  ComplicationController.swift
//  OrlandoParkingWatch Extension
//
//  Created by Keli'i Martin on 3/23/17.
//  Copyright © 2017 WERUreo. All rights reserved.
//

import ClockKit
import OPRequestService

class ComplicationController: NSObject, CLKComplicationDataSource
{
    ////////////////////////////////////////////////////////////
    // MARK: - Timeline Configuration
    ////////////////////////////////////////////////////////////

    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void)
    {
        handler([])
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Timeline Population
    ////////////////////////////////////////////////////////////

    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void)
    {
        switch complication.family
        {
            case .modularSmall:
                let template = CLKComplicationTemplateModularSmallStackText()
                template.line1TextProvider = CLKSimpleTextProvider(text: "EVTS")
                template.line2TextProvider = CLKSimpleTextProvider(text: "\(OPRequestManager.shared.eventCount)")

                let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
                handler(entry)
            case .modularLarge:
                let template = CLKComplicationTemplateModularLargeStandardBody()
                template.headerTextProvider = CLKSimpleTextProvider(text: "Events")
                template.body1TextProvider = CLKSimpleTextProvider(text: "\(OPRequestManager.shared.eventCount)")

                let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
                handler(entry)
            default:
                handler(nil)
        }
    }
    
    ////////////////////////////////////////////////////////////
    // MARK: - Placeholder Templates
    ////////////////////////////////////////////////////////////

    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void)
    {
        switch complication.family
        {
            case .modularSmall:
                let template = CLKComplicationTemplateModularSmallStackText()
                template.line1TextProvider = CLKSimpleTextProvider(text: "Events", shortText: "EVT")
                template.line2TextProvider = CLKSimpleTextProvider(text: "---")

                handler(template)
            case .modularLarge:
                let template = CLKComplicationTemplateModularLargeStandardBody()
                template.headerTextProvider = CLKSimpleTextProvider(text: "Events")
                template.body1TextProvider = CLKSimpleTextProvider(text: "---")

                handler(template)
            default:
                handler(nil)
        }
    }
}
