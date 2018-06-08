//
//  HintCell.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 6/7/18.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

class HintCell: CollectionViewCell {
    fileprivate var stackView = UIStackView()
    fileprivate var numberOfCharacters = CharacterTile()
    fileprivate var wordsFount = UILabel()
    fileprivate var totalWords = UILabel()
    
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
        addSubview(stackView)
        stackView.addArrangedSubview(numberOfCharacters)
        stackView.addArrangedSubview(wordsFount)
        stackView.addArrangedSubview(totalWords)
        
        numberOfCharacters.snp.makeConstraints { make in
            make.width.equalTo(numberOfCharacters.snp.height)
            make.height.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    fileprivate func style() {
        backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.spacing = 10.0
        stackView.alignment = .center
        numberOfCharacters.characterLabel.style(.hintTile)
        wordsFount.style(.book13White)
        totalWords.style(.book13White)
    }
    
    func update(withWords words: [String], guessedWords:[String]) {
        if let count = words.first?.count {
            numberOfCharacters.update(with:
            "\(count)")
        }
        
        wordsFount.text = "\(guessedWords.count)"
        totalWords.text = "of \(words.count)"
    }
}
