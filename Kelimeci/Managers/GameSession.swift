//
//  GameSession.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 8/24/17.
//  Copyright © 2017 Emel Topaloglu. All rights reserved.
//

import Foundation

class GameSession: NSObject {
    enum Difficulty {
        case easy
        case medium
        case difficult
    }

    static let shared: GameSession = GameSession()
    var difficulty = GameSession.Difficulty.easy {
        didSet {
            loadGames()
        }
    }
    var availableWords: [Word] = []
    var time: Int {
        switch difficulty {
        case .easy:
            return 180
        case .medium:
            return 240
        case .difficult:
            return 300
        }
    }
    
    var nextWord: Word? {
        return availableWords.first
    }
    
    func loadGames() {
        availableWords = []
        switch difficulty {
        case .easy:
            availableWords.append(contentsOf: Parser().parseGames(with: "8_characters"))
            availableWords.append(contentsOf: Parser().parseGames(with: "9_characters"))
        case .medium:
            availableWords.append(contentsOf: Parser().parseGames(with: "10_characters"))
            availableWords.append(contentsOf: Parser().parseGames(with: "11_characters"))
        case .difficult:
            availableWords.append(contentsOf: Parser().parseGames(with: "12_characters"))
            availableWords.append(contentsOf: Parser().parseGames(with: "13_characters"))
        }
        availableWords = availableWords.shuffled()
        let usedWords = KeychainManager.shared.getStoredGames(forDifficulty: difficulty)
        for (index, element) in availableWords.enumerated().reversed() {
            let characterSting = element.characters.joined()
            if usedWords.contains(characterSting) {
                availableWords.remove(at: index)
            }
        }
        
        if availableWords.count == 0 {
            resetUsedWords()
        }
    }
    
    func finishWord(word: Word) {
        let characterSting = word.characters.joined()
        KeychainManager.shared.storeGame(withMainWord: characterSting, difficulty: difficulty)
        availableWords.removeFirst()
        if availableWords.count == 0 {
            resetUsedWords()
        }
    }
    
    func resetUsedWords() {
        KeychainManager.shared.clearStoredGames(forDifficulty: difficulty)
        loadGames()
    }
}
