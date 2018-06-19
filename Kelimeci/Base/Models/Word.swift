//
//  Word.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 6/3/18.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

class Word {
    var characters: [String] = []
    var thirteenLetters: [String] = []
    var twelveLetters: [String] = []
    var elevenLetters: [String] = []
    var tenLetters: [String] = []
    var nineLetters: [String] = []
    var eightLetters: [String] = []
    var sevenLetters: [String] = []
    var sixLetters: [String] = []
    var fiveLetters: [String] = []
    var fourLetters: [String] = []
    
    var allWords: [String] {
        let allResults = thirteenLetters + twelveLetters + elevenLetters + tenLetters + nineLetters + eightLetters + sevenLetters + sixLetters + fiveLetters + fourLetters
        return allResults
    }
}
