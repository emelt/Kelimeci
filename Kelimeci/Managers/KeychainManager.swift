//
//  KeychainManager.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 6/5/18.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation
import KeychainAccess

class KeychainManager: NSObject {
    struct Constants {
        static let service = "com.emeltopaloglu.kelimeci"
        static let playedGamesEasy = "playedGamesEasy"
        static let playedGamesMedium = "playedGamesMedium"
        static let playedGamesDifficult = "playedGamesDifficult"
    }
    
    static let shared: KeychainManager = KeychainManager()
    fileprivate let keychain = Keychain(service: Constants.service)
    
    func keychainString(forDifficulty difficulty: GameSession.Difficulty) -> String {
        switch difficulty {
        case .easy:
            return Constants.playedGamesEasy
        case .medium:
            return Constants.playedGamesMedium
        case .difficult:
            return Constants.playedGamesDifficult
        }
    }
    
    func getStoredGames(forDifficulty difficulty: GameSession.Difficulty) -> [String] {
        let string = keychainString(forDifficulty: difficulty)
        if let gamesData = try? keychain.getData(string), gamesData != nil {
            if let games = try? JSONDecoder().decode([String].self, from: gamesData!) {
                return games
            }
        }
        return []
    }
    
    func storeGame(withMainWord word: String, difficulty: GameSession.Difficulty) {
        var storedGames = self.getStoredGames(forDifficulty: difficulty)
        if !storedGames.contains(word) {
            storedGames.append(word)
        }
        if let data = try? JSONEncoder().encode(storedGames) {
            try? keychain.set(data, key: keychainString(forDifficulty: difficulty))
        }
    }
    
    func clearStoredGames(forDifficulty difficulty: GameSession.Difficulty) {
        let emptyGames: [String] = []
        if let data = try? JSONEncoder().encode(emptyGames) {
            try? keychain.set(data, key: keychainString(forDifficulty: difficulty))
        }
    }
}
