//
//  GuessedWord.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 8/24/17.
//  Copyright © 2017 Emel Topaloglu. All rights reserved.
//

import UIKit
import SnapKit

class GuessedWord: UIView {
    fileprivate var label = UILabel()
    var underlineView = UIView()
    
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
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        label.addSubview(underlineView)
        underlineView.snp.makeConstraints { make in
            make.height.equalTo(3.0)
            make.leading.equalToSuperview().offset(10.0)
            make.trailing.equalToSuperview().offset(-10.0)
            make.bottom.equalToSuperview()
        }
    }
    
    fileprivate func style() {
        backgroundColor = .clear
        underlineView.backgroundColor = .kPink
        label.textAlignment = .center
        label.style(.guessedWord)
    }
    
    func append(character: String) {
        label.text = (label.text ?? "") + character
    }
    
    func removeLast() -> String {
        guard let text = label.text else { return ""}
        if !text.isEmpty, let character = label.text?.removeLast() {
            return "\(character)"
        }
        return ""
    }
    
    func clear() {
        label.text?.removeAll()
    }
}
