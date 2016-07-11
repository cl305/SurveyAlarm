//
//  ResultParser.swift
//  SurveyAlarm
//
//  Created by Cody Li on 7/8/16.
//  Copyright © 2016 Cody Li. All rights reserved.
//

import Foundation
import ResearchKit

struct ResultParser {
    static func findSurveyResults(result: ORKTaskResult) -> [NSURL] {
        
        var urls = [NSURL]()
//        print(result.results!)
        if let results = result.results
            where results.count < 4,
            let surveyResult = results[1] as? ORKStepResult{
           
            for result in surveyResult.results! {
                if let result = result as? ORKFileResult,
                    let fileURL = result.fileURL {
                        urls.append(fileURL)
                    
                }
            }
        }
        return urls
    }
}