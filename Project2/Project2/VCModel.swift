//
//  VCModel.swift
//  Project2
//
//  Created by Shantanu Dutta on 18/03/19.
//  Copyright © 2019 Shantanu Dutta. All rights reserved.
//

import Foundation

class VCModel {
    private var countries = [String]()
    private(set) var correctAnswer = 0
    private(set) var score = 0
    private var totalQuestions = 0
    
    var answerCountryName: String {
        return formatCountryName(for: countries[correctAnswer])
    }
    
    var isRoundComplete: Bool {
        return totalQuestions == 10
    }
    
    func setData() {
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
    }
    
    func getCountryName(for index: Int) -> String {
        return formatCountryName(for: countries[index])
    }
    
    func resetData() {
        totalQuestions = 0
        score = 0
        correctAnswer = 0
    }
    
    func askQuestion() -> [String] {
        totalQuestions += 1
        countries.shuffle()
        let answer = Int.random(in: 0...2)
        let countryOptions = [countries[0], countries[1], countries[2]]
        correctAnswer = answer
        return countryOptions
    }
    
    func updateScore(with currentAnswer: Bool) {
        score += (currentAnswer) ? 1 : 0
    }
    
    private func formatCountryName(for name: String) -> String {
        return name.count == 2 ? name.uppercased() : name.capitalized
    }
}
