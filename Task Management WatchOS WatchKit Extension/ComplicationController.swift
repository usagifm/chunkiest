//
//  ComplicationController.swift
//  SepotipaiW WatchKit Extension
//
//  Created by Muhammad Tafani Rabbani on 14/07/22.
//

import ClockKit
import SwiftUI

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Complication Configuration

    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: "complication", displayName: "Task Done for Chunkist", supportedFamilies: CLKComplicationFamily.allCases)
            // Multiple complication support can be added here with more descriptors
        ]
        
        // Call the handler with the currently supported complication descriptors
        handler(descriptors)
    }
    
    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Do any necessary work to support these newly shared complication descriptors
    }

    // MARK: - Timeline Configuration
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        // Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        // Call the handler with your desired behavior when the device is locked
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // TODO: Get song data (opt 2)

        // Call the handler with the current timeline entry
        if let template = getComplicationTemplate(for: complication) {
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(entry)
        } else {
            handler(nil)
        }
    }
    
    func getComplicationTemplate(for complication: CLKComplication) -> CLKComplicationTemplate? {
        // TODO: Get song data (opt 1)
        
        switch complication.family {
        case .graphicCircular:
            return CLKComplicationTemplateGraphicCircularView(CircularComplicationViewTest(progress: 0.80))
//        case .graphicRectangular:CLKComplicationTemplateGraphicCircularView
            
            ////            return CLKComplicationTemplateGraphicRectangularStandardBody(headerTextProvider: CLKTextProvider(format: "Now"), body1TextProvider: CLKTextProvider(format: "Playing"))
//            return CLKComplicationTemplateGraphicRectangularFullView(RectangularComplicationView(progress: 0.1, song: Song(singer: "Def Ghij", title: "abc")))
        default:
            return nil
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after the given date
        handler(nil)
    }

    // MARK: - Sample Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }
}
