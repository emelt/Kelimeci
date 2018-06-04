//
//  StatsView.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 8/24/17.
//  Copyright © 2017 Emel Topaloglu. All rights reserved.
//

import UIKit

class StatsView: UIView {
    fileprivate var label = UILabel()
    
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
        label.textAlignment = .center
    }
    
    func append(character: String) {
        label.text = (label.text ?? "") + character
    }
    
    func delete(character: String) {
        label.text?.removeLast()
    }
    
    func clear() {
        label.text?.removeAll()
    }
}
