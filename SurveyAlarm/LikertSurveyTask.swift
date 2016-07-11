//
//  LikertSurveyTask.swift
//  SurveyAlarm
//
//  Created by Cody Li on 7/7/16.
//  Copyright © 2016 Cody Li. All rights reserved.
//

import Foundation
import ResearchKit

public var LikertSurveyTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    let instructionStep = ORKInstructionStep(identifier:  "IntroStep")
    instructionStep.title = "Multiple choice survey"
    instructionStep.text = "In this survey, select the best choice for each question. Tap 'Get Started' to begin the survey."
    steps += [instructionStep]
    
    let mcQuestionTitle_One = "How many hours did you sleep last night?"
    let mcQuestionChoices_One = [
        ORKTextChoice(text: "Less than seven", value: 0),
        ORKTextChoice(text: "Between seven and eight", value: 1),
        ORKTextChoice(text: "More than eight", value: 2)
    ]
    let mcQuestionFormat_One = ORKTextChoiceAnswerFormat(style: .SingleChoice, textChoices: mcQuestionChoices_One)
    let mcQuestionStep_One = ORKQuestionStep(identifier: "LikertStepOne", title: mcQuestionTitle_One, answer: mcQuestionFormat_One)
    steps += [mcQuestionStep_One]
    
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Tap 'Done' to complete the survey."
    summaryStep.text = "Your phone will notify you again of when to complete another survey."
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "LikertSurveyTask", steps: steps)
}