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
        case guessed
        case failed
    }
    
    fileprivate var label = UILabel()
    fileprivate var word = ""
    var state: State = .guessed

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
            case .guessed:
            label.style(.matchingGuess)
            label.text = word
            case .failed:
            label.style(.missingGuess)
            label.text = word
        }
    }
}
