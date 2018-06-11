//
//  LettersView.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 8/24/17.
//  Copyright © 2017 Emel Topaloglu. All rights reserved.
//

import UIKit
import SnapKit

protocol LettersViewDelegate: class {
    func tilesViewDidSelectItem(view: LettersView, character: String)
}

class LettersView: UIView {
    weak var delegate: LettersViewDelegate?
    fileprivate lazy var collectionView: UICollectionView = {
        var flowLayout = KTCenterFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.sectionInset = UIEdgeInsetsMake(0.0, 20.0, 0.0, 20.0)
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        collectionView.register(CharacterTile.self, forCellWithReuseIdentifier: CharacterTile.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    fileprivate var backgroundImageView = UIImageView()
    fileprivate var characters: [String] = []
    fileprivate var disabledIndexes: [IndexPath] = []
    
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
        addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func style() {
        backgroundColor = .clear
        collectionView.backgroundColor = .clear
    }
    
    func update(with characters: [String]) {
        self.characters = characters.shuffled()
        self.disabledIndexes = []
        collectionView.reloadData()
    }
    
    func add(character: String) {
        for index in disabledIndexes where characters[index.row] == character {
            let cell = collectionView.cellForItem(at: index)
            UIView.animate(withDuration: 0.2) {
                cell?.alpha = 1.0
            }
            disabledIndexes.remove(index)
            return
        }
    }
    
    func shuffle() {
        UIView.animate(withDuration: 0.2, animations: {
            self.collectionView.alpha = 0.0
        }) { completed in
            self.update(with: self.characters)
            UIView.animate(withDuration: 0.2, animations: {
                self.collectionView.alpha = 1.0
            })
        }
    }
}

extension LettersView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var count: Int = characters.count
        if count >= 7 {
            count = Int(floor(Double(characters.count / 2)))
        }
        
        if count < 5 {
            count = 5
        }
        
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let itemSpacing = CGFloat(count - 1) * flowLayout.minimumInteritemSpacing
            let width = (UIScreen.main.bounds.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - itemSpacing) / CGFloat(count)
            return CGSize(width: width, height: width)
        }
        
        return CGSize()
    }
}

// MARK: - UICollectionViewDataSource
extension LettersView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterTile.reuseIdentifier, for: indexPath) as? CharacterTile {
            cell.update(with: characters[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? CharacterTile, characters.count > indexPath.item {
            cell.update(with: characters[indexPath.row])
        }
    }
}

extension LettersView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if disabledIndexes.contains(indexPath) {
            return
        }
        
        let item = characters[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath)
        disabledIndexes.append(indexPath)
        delegate?.tilesViewDidSelectItem(view: self, character: item)
        UIView.animate(withDuration: 0.2) {
            cell?.alpha = 0.2
        }
    }
}
