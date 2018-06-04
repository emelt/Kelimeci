//
//  MatchTile.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 6/4/18.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import UIKit

class MatchTile: CollectionViewCell {
    enum State {
        case missing
        case guessed
        case failed
    }
    
    fileprivate var label = UILabel()
    fileprivate var word = ""
    var state: State = .missing

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
        label.backgroundColor = .kSoftWhite
        label.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func style() {
        backgroundColor = .kSoftWhite
        label.textAlignment = .center
    }
    
    func update(with word: String, state: State) {
        self.word = word
        self.state = state
        switch state {
            case .missing:
            label.style(.missingGuess)
            label.text = String(repeating: "*", count: word.count)
            case .guessed:
            label.style(.matchingGuess)
            label.text = word
            case .failed:
            label.style(.missingGuess)
            label.text = word
        }
    }
    
    func highlight() {
        let animator = UIViewPropertyAnimator(duration: 0.1, curve: .easeIn) {
            self.label.font = .mfAvenirRoman(size: 12.0)
            }
        animator.addCompletion { _ in
            self.label.font = .mfAvenirRoman(size: 10.0)
        }
        animator.startAnimation()
    }
    
    func correctGuess() {
        self.label.text = self.word
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeIn) {
            self.label.font = .mfAvenirRoman(size: 12.0)
            self.label.textColor = .kPink
        }
        
        animator.addCompletion { _ in
            self.label.font = .mfAvenirRoman(size: 10.0)
            self.state = .guessed
        }
        animator.startAnimation()
    }
    
    func revealAnswer() {
        self.label.text = self.word
        let animator = UIViewPropertyAnimator(duration: 0.1, curve: .easeIn) {
            self.label.font = .mfAvenirRoman(size: 12.0)
            self.label.textColor = .kGray
        }
        animator.addCompletion { _ in
            self.label.font = .mfAvenirRoman(size: 10.0)
            self.state = .failed
        }
        animator.startAnimation()
    }
}
