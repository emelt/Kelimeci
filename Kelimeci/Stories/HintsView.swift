//
//  HintsView.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 6/4/18.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

class HintsView: UIView {
    fileprivate var backgroundImageView = UIImageView()
    fileprivate var stackView = UIStackView()
    fileprivate var word: Word?
    fileprivate var label = UILabel()
    fileprivate var fiveLetters = UILabel()
    fileprivate var sixLetters = UILabel()
    fileprivate var sevenLetters = UILabel()
    fileprivate var eightLetters = UILabel()
    fileprivate var nineLetters = UILabel()
    fileprivate var tenLetters = UILabel()
    fileprivate var elevenLetters = UILabel()
    fileprivate var twelveLetters = UILabel()
    fileprivate var thirteenLetters = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        style()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
        style()
    }
    
    fileprivate func setupSubviews() {
        addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func style() {
        backgroundColor = .clear
        label.style(.book13White)
        label.numberOfLines = 0
    }
    
    func update(withWord word: Word) {
        var text = ""
        if word.twelveLetters.count > 0 {
            text.append("\(word.twelveLetters.count) - 12 Char, ")
        }
        if word.elevenLetters.count > 0 {
            text.append("\(word.elevenLetters.count) - 11 Char, ")
        }
        if word.tenLetters.count > 0 {
            text.append("\(word.tenLetters.count) - 10 Char, ")
        }
        if word.nineLetters.count > 0 {
            text.append("\(word.nineLetters.count) - 9 Char, ")
        }
        if word.eightLetters.count > 0 {
            text.append("\(word.eightLetters.count) - 8 Char, ")
        }
        if word.sevenLetters.count > 0 {
            text.append("\(word.sevenLetters.count) - 7 Char, ")
        }
        if word.sixLetters.count > 0 {
            text.append("\(word.sixLetters.count) - 6 Char, ")
        }
        if word.fiveLetters.count > 0 {
            text.append("\(word.fiveLetters.count) - 5 Char, ")
        }
        if word.fourLetters.count > 0 {
            text.append("\(word.fourLetters.count) - 4 Char")
        }
        label.text = text
    }
}
