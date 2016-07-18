//
//  MCSurvey.swift
//  SurveyAlarm
//
//  Created by Cody Li on 7/6/16.
//  Copyright © 2016 Cody Li. All rights reserved.
//

import Foundation
import ResearchKit

public var CheckAllSurveyTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    let instructionStep = ORKInstructionStep(identifier:  "IntroStep")
    instructionStep.title = "Daily Survey"
    instructionStep.text = "In this survey, please select all of the choices that apply to you. Tap 'Get Started' to begin the survey."
    steps += [instructionStep]
    
    let mcQuestionTitle_One = "Which symptoms do you have?"
    let mcQuestionChoices_One = [
        ORKTextChoice(text: "Cough", detailText: "A cough and/or sore throat", value: 0, exclusive: false),
        ORKTextChoice(text: "Fever", detailText: "A 100F or higher fever or feeling feverish", value: 1, exclusive: false),
        ORKTextChoice(text: "Headaches", detailText: "Headaches and/or body aches", value: 2, exclusive: false)
    ]
    
    let mcQuestionFormat_One = ORKTextChoiceAnswerFormat(style: .MultipleChoice, textChoices: mcQuestionChoices_One)
    let mcQuestionStep_One = ORKQuestionStep(identifier: "CheckAllStep1", title: mcQuestionTitle_One, answer: mcQuestionFormat_One)
    steps += [mcQuestionStep_One]
    
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Tap 'Done' to complete the survey."
    summaryStep.text = "Your phone will notify you again of when to complete another survey."
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "CheckAllSurveyTask", steps: steps)
}