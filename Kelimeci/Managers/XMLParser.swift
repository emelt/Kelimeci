//
//  XMLParser.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 8/24/17.
//  Copyright © 2017 Emel Topaloglu. All rights reserved.
//

import Foundation


class Parser: NSObject {
    
    struct Constants {
        static let characters = "characters"
        static let games = "game"
        static let thirteenLetters = "letters_13"
        static let twelveLetters = "letters_12"
        static let elevenLetters = "letters_11"
        static let tenLetters = "letters_10"
        static let nineLetters = "letters_9"
        static let eightLetters = "letters_8"
        static let sevenLetters = "letters_7"
        static let sixLetters = "letters_6"
        static let fiveLetters = "letters_5"
        static let fourLetters = "letters_4"
    }
    
    static let characters: String = "characters"
    
    var words: [Word] = []
    var eName: String = String()
    var characters: String = ""
    var thirteenLetters: String?
    var twelveLetters: String?
    var elevenLetters: String?
    var tenLetters: String?
    var nineLetters: String?
    var eightLetters: String?
    var sevenLetters: String?
    var sixLetters: String?
    var fiveLetters: String?
    var fourLetters: String?
    
    func parseGames(with name: String) -> [Word] {
        if let path = Bundle.main.url(forResource: name, withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
        return words
    }
}

extension Parser: XMLParserDelegate {
    // 1
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        eName = elementName
        if elementName == Constants.games {
            characters = ""
            thirteenLetters = nil
            twelveLetters = nil
            elevenLetters = nil
            tenLetters = nil
            nineLetters = nil
            eightLetters = nil
            sevenLetters = nil
            sixLetters = nil
            fiveLetters = nil
            fourLetters = nil
        }
    }
    
    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == Constants.games {
            let word = Word()
            word.characters = characters.components(separatedBy: ",")
            word.thirteenLetters = thirteenLetters?.components(separatedBy: ",") ?? []
            word.twelveLetters = twelveLetters?.components(separatedBy: ",") ?? []
            word.elevenLetters = elevenLetters?.components(separatedBy: ",") ?? []
            word.tenLetters = tenLetters?.components(separatedBy: ",") ?? []
            word.nineLetters = nineLetters?.components(separatedBy: ",") ?? []
            word.eightLetters = eightLetters?.components(separatedBy: ",") ?? []
            word.sevenLetters = sevenLetters?.components(separatedBy: ",") ?? []
            word.sixLetters = sixLetters?.components(separatedBy: ",") ?? []
            word.fiveLetters = fiveLetters?.components(separatedBy: ",") ?? []
            word.fourLetters = fourLetters?.components(separatedBy: ",") ?? []
            words.append(word)
        }
    }
    
    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        var data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        data = string.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
        if (!data.isEmpty) {
            if eName == Constants.characters {
                characters.append(data)
            } else if eName == Constants.thirteenLetters {
                if thirteenLetters == nil {
                    thirteenLetters = ""
                }
                thirteenLetters?.append(data)
            } else if eName == Constants.twelveLetters {
                if twelveLetters == nil {
                    twelveLetters = ""
                }
                twelveLetters?.append(data)
            } else if eName == Constants.elevenLetters {
                if elevenLetters == nil {
                    elevenLetters = ""
                }
                elevenLetters?.append(data)
            } else if eName == Constants.tenLetters {
                if tenLetters == nil {
                    tenLetters = ""
                }
                tenLetters?.append(data)
            } else if eName == Constants.nineLetters {
                if nineLetters == nil {
                    nineLetters = ""
                }
                nineLetters?.append(data)
            } else if eName == Constants.eightLetters {
                if eightLetters == nil {
                    eightLetters = ""
                }
                eightLetters?.append(data)
            } else if eName == Constants.sevenLetters {
                if sevenLetters == nil {
                    sevenLetters = ""
                }
                sevenLetters?.append(data)
            } else if eName == Constants.sixLetters {
                if sixLetters == nil {
                    sixLetters = ""
                }
                sixLetters?.append(data)
            } else if eName == Constants.fiveLetters {
                if fiveLetters == nil {
                    fiveLetters = ""
                }
                fiveLetters?.append(data)
            } else if eName == Constants.fourLetters {
                if fourLetters == nil {
                    fourLetters = ""
                }
                fourLetters?.append(data)
            }
        }
    }
}
