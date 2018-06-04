//
//  MatchesView.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 8/24/17.
//  Copyright © 2017 Emel Topaloglu. All rights reserved.
//

import UIKit

class MatchesView: UIView {
    fileprivate lazy var collectionView: UICollectionView = {
        var flowLayout = KTCenterFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.sectionInset = UIEdgeInsetsMake(10.0, 20.0, 10.0, 20.0)
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        collectionView.register(MatchTile.self, forCellWithReuseIdentifier: MatchTile.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    fileprivate var matches: [String] = []
    var missingIndexes: [IndexPath] = []
    fileprivate var allWords: [String] = []
    var revealed: Bool = false
    var word: Word? {
        didSet {
            guard let word = word else {
                allWords = []
                return
            }
            let allResults = word.thirteenLetters + word.twelveLetters + word.elevenLetters + word.tenLetters + word.nineLetters + word.eightLetters + word.sevenLetters + word.sixLetters + word.fiveLetters + word.fourLetters
            allWords = allResults
            collectionView.reloadData()
        }
    }

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
        addSubview(collectionView)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func style() {
        backgroundColor = .clear
        collectionView.backgroundColor = .clear
    }

    func guess(word: String) {
        //find a place to insert the word
        matches.append(word)
        matches.sort { $0.count > $1.count || ($0.count == $1.count && $0 < $1) } //
        let newIndex = matches.index(of: word)
        collectionView.insertItems(at: [IndexPath(row: newIndex!, section: 0)])
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func revealAll() {
        guard let word = word else { return }
        let allResults = word.thirteenLetters + word.twelveLetters + word.elevenLetters + word.tenLetters + word.nineLetters + word.eightLetters + word.sevenLetters + word.sixLetters + word.fiveLetters + word.fourLetters
        missingIndexes = []
        for (index, item) in allResults.enumerated() {
            if !matches.contains(item) {
                missingIndexes.append(IndexPath(row: index, section: 0))
            }
        }
        
        matches = allResults
        collectionView.insertItems(at: missingIndexes)
        collectionView.collectionViewLayout.invalidateLayout()
    }
}


// MARK: - UICollectionViewDataSource
extension MatchesView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return matches.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchTile.reuseIdentifier, for: indexPath) as? MatchTile {
            if missingIndexes.contains(indexPath) {
                cell.update(with: matches[indexPath.row], state: .missing)
            } else {
                cell.update(with: matches[indexPath.row], state: .guessed)
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MatchesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = matches[indexPath.row]
        let textAttributes = [NSAttributedStringKey.font : UIFont.mfAvenirRoman(size: 10.0)]
        let size = text.size(withAttributes: textAttributes)
        return CGSize(width: size.width + 10.0, height: size.height + 8.0)
    }
}
