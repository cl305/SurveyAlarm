//
//  SurveyTask.swift
//  SurveyAlarm
//
//  Created by Cody Li on 7/5/16.
//  Copyright © 2016 Cody Li. All rights reserved.
//

import Foundation
import ResearchKit

public var SurveyTask: ORKOrderedTask {

    var steps = [ORKStep]()
    
    let instructionStep = ORKInstructionStep(identifier:  "IntroStep")
    instructionStep.title = "The questions Three"
    instructionStep.text = "Who would cross the Bridge of Death must answer me these questions three, ere the other side they see."
    steps += [instructionStep]
    
    let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
    nameAnswerFormat.multipleLines = false
    let nameQuestionStepTitle = "what is your name?"
    let nameQuestionStep = ORKQuestionStep(identifier: "QuestionStep", title: nameQuestionStepTitle, answer: nameAnswerFormat)
    steps += [nameQuestionStep]
    
    let questQuestionStepTitle = "What is your quest?"
    let textChoices = [
        ORKTextChoice(text: "Create a ResearchKit App", value: 0),
        ORKTextChoice(text: "Seek the Holy Grail", value: 1),
        ORKTextChoice(text: "Find a shrubbery", value: 2)
    ]
    let questAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
    let questQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep", title: questQuestionStepTitle, answer: questAnswerFormat)
    steps += [questQuestionStep]
    
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}