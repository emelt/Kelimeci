//
//  CharacterTile.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 8/24/17.
//  Copyright © 2017 Emel Topaloglu. All rights reserved.
//

import UIKit
import SnapKit

class CharacterTile: CollectionViewCell {
    fileprivate var characterLabel = UILabel()
    fileprivate var backgroundImageView = UIImageView()
    
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
        addSubview(backgroundImageView)
        addSubview(characterLabel)
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        characterLabel.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func style() {
        backgroundColor = .kSoftWhite
        characterLabel.textAlignment = .center
        characterLabel.style(.characterTile)
        style(.tile)
    }
    
    func update(with character: String) {
        characterLabel.text = character
    }
}
