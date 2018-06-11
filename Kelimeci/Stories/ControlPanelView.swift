//
//  ControlPanelView.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 6/3/18.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import UIKit

protocol ControlPanelViewDelegate: class {
    func deleteButtonTapped(view: ControlPanelView)
    func guessButtonTapped(view: ControlPanelView)
    func resetButtonTapped(view: ControlPanelView)
    func shuffleButtonTapped(view: ControlPanelView)
}


class ControlPanelView: UIView {
    weak var delegate: ControlPanelViewDelegate?
    fileprivate var deleteButton = UIButton()
    fileprivate var guessButton = UIButton()
    fileprivate var resetButton = UIButton()
    fileprivate var shuffleButton = UIButton()
    fileprivate var stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        style()
        addButtonActions()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
        style()
        addButtonActions()
    }
    
    fileprivate func setupSubviews() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(shuffleButton)
        stackView.addArrangedSubview(resetButton)
        stackView.addArrangedSubview(deleteButton)
        stackView.addArrangedSubview(guessButton)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(40.0)
            make.trailing.equalToSuperview().offset(-40.0)
        }
        
        guessButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(guessButton.snp.height)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(deleteButton.snp.height)
        }
        
        shuffleButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(shuffleButton.snp.height)
        }
        
        resetButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(resetButton.snp.height)
        }
    }
    
    fileprivate func style() {
        backgroundColor = .clear
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        resetButton.setImage(#imageLiteral(resourceName: "iconTrash"), for: .normal)
        shuffleButton.setImage(#imageLiteral(resourceName: "iconShuffle"), for: .normal)
        deleteButton.setImage(#imageLiteral(resourceName: "iconUndo"), for: .normal)
        guessButton.setImage(#imageLiteral(resourceName: "iconCheck"), for: .normal)
    }
    
    func addButtonActions() {
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        guessButton.addTarget(self, action: #selector(guessButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        shuffleButton.addTarget(self, action: #selector(shuffleButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func deleteButtonTapped() {
        delegate?.deleteButtonTapped(view: self)
    }
    
    @objc
    func guessButtonTapped() {
        delegate?.guessButtonTapped(view: self)
    }
    
    @objc
    func shuffleButtonTapped() {
        delegate?.shuffleButtonTapped(view: self)
    }
    
    @objc
    func resetButtonTapped() {
        delegate?.resetButtonTapped(view: self)
    }
}
