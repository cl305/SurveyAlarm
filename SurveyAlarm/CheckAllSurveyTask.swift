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
    let mcQuestionStep_One = ORKQuestionStep(identifier: "MCStepOne", title: mcQuestionTitle_One, answer: mcQuestionFormat_One)
    steps += [mcQuestionStep_One]
    
//    let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
//    nameAnswerFormat.multipleLines = false
//    let nameQuestionStepTitle = "what is your name?"
//    let nameQuestionStep = ORKQuestionStep(identifier: "QuestionStep", title: nameQuestionStepTitle, answer: nameAnswerFormat)
//    steps += [nameQuestionStep]
//    
//    let questQuestionStepTitle = "What is your quest?"
//    let textChoices = [
//        ORKTextChoice(text: "Create a ResearchKit App", value: 0),
//        ORKTextChoice(text: "Seek the Holy Grail", value: 1),
//        ORKTextChoice(text: "Find a shrubbery", value: 2)
//    ]
//    let questAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
//    let questQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep", title: questQuestionStepTitle, answer: questAnswerFormat)
//    steps += [questQuestionStep]
    
    return ORKOrderedTask(identifier: "MCSurveyTask", steps: steps)
}