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
        static let playedGames = "playedGames"
    }
    
    static let shared: KeychainManager = KeychainManager()
    fileprivate let keychain = Keychain(service: Constants.service)
    
    var storedGames: [String] {
        if let gamesData = try? keychain.getData(Constants.playedGames), gamesData != nil {
            if let games = try? JSONDecoder().decode([String].self, from: gamesData!) {
                return games
            }
        }
        return []
    }
    
    func storeGame(withMainWord word: String) {
        var storedGames = self.storedGames
        if !storedGames.contains(word) {
            storedGames.append(word)
        }
        if let data = try? JSONEncoder().encode(storedGames) {
            try? keychain.set(data, key: Constants.playedGames)
        }
    }
}
