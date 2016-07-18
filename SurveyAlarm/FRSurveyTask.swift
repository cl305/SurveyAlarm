//
//  FRSurveyTask.swift
//  SurveyAlarm
//
//  Created by Cody Li on 7/6/16.
//  Copyright © 2016 Cody Li. All rights reserved.
//

import Foundation
import ResearchKit

public var FRSurveyTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    let instructionStep = ORKInstructionStep(identifier:  "IntroStep")
    instructionStep.title = "Free response survey."
    instructionStep.text = "Please type your responses to each of the questions in this survey. Tap 'Get Started' to begin the survey."
    steps += [instructionStep]
    
    let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 200)
    nameAnswerFormat.multipleLines = true
    let nameQuestionStepTitle = "How are you?"
    let nameQuestionStep = ORKQuestionStep(identifier: "FRQuestionStep1", title: nameQuestionStepTitle, answer: nameAnswerFormat)
    steps += [nameQuestionStep]
    
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Tap 'Done' to complete the survey."
    summaryStep.text = "Your phone will notify you again of when to complete another survey."
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "FRSurveyTask", steps: steps)
}