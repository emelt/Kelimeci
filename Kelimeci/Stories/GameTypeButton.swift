//
//  GameTypeButton.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 6/4/18.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

class GameTypeButton: UIButton {
    fileprivate var stackView = UIStackView()
    fileprivate var label = UILabel()
    fileprivate var detailLabel = UILabel()
    
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
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(detailLabel)

        stackView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        
        stackView.isUserInteractionEnabled = false
    }
    
    fileprivate func style() {
        backgroundColor = .kPink
        stackView.axis = .vertical
        label.textAlignment = .center
        detailLabel.textAlignment = .center
        label.style(.gameTypeLabel)
        detailLabel.style(.gameTypeDetailLabel)
        layer.cornerRadius = 25.0
    }
    
    func update(forTitle title: String, subtitle: String) {
        label.text = title
        detailLabel.text = subtitle
    }
}
