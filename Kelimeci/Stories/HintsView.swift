//
//  HintsView.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 6/4/18.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

class HintsView: UIView {
    fileprivate lazy var collectionView: UICollectionView = {
        var flowLayout = KTCenterFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        collectionView.register(HintCell.self, forCellWithReuseIdentifier: HintCell.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    fileprivate var backgroundImageView = UIImageView()
    fileprivate var stackView = UIStackView()
    fileprivate var word: Word?
    fileprivate var guessedWords = Word()
    fileprivate var charCountToIndexMap: [Int: Int] = [:]
    
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
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func style() {
        backgroundColor = .clear
        collectionView.backgroundColor = .clear
    }
    
    func update(withWord word: Word) {
        self.word = word
        guessedWords = Word()
        guessedWords.characters = []
    }
    
    func userDidGuess(word: String) {
        if word.count == 13 {
            guessedWords.thirteenLetters.append(word)
        }
        if word.count == 12 {
            guessedWords.twelveLetters.append(word)
        }
        if word.count == 11 {
            guessedWords.elevenLetters.append(word)
        }
        if word.count == 10 {
            guessedWords.tenLetters.append(word)
        }
        if word.count == 9 {
            guessedWords.nineLetters.append(word)
        }
        if word.count == 8 {
            guessedWords.eightLetters.append(word)
        }
        if word.count == 7 {
            guessedWords.sevenLetters.append(word)
        }
        if word.count == 6 {
            guessedWords.sixLetters.append(word)
        }
        if word.count == 5 {
            guessedWords.fiveLetters.append(word)
        }
        if word.count == 4 {
            guessedWords.fourLetters.append(word)
        }
        
        let indexPath = IndexPath(row: abs(word.count - 13), section: 0)
        collectionView.reloadItems(at: [indexPath])
    }
}


// MARK: - UICollectionViewDataSource
extension HintsView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HintCell.reuseIdentifier, for: indexPath) as? HintCell {
            guard let word = word else { return cell }
            
            switch indexPath.row {
            case 0:
                cell.update(withWords: word.thirteenLetters, guessedWords: guessedWords.thirteenLetters)
            case 1:
                cell.update(withWords: word.twelveLetters, guessedWords: guessedWords.twelveLetters)
            case 2:
                cell.update(withWords: word.elevenLetters, guessedWords: guessedWords.elevenLetters)
            case 3:
                cell.update(withWords: word.tenLetters, guessedWords: guessedWords.tenLetters)
            case 4:
                cell.update(withWords: word.nineLetters, guessedWords: guessedWords.nineLetters)
            case 5:
                cell.update(withWords: word.eightLetters, guessedWords: guessedWords.eightLetters)
            case 6:
                cell.update(withWords: word.sevenLetters, guessedWords: guessedWords.sevenLetters)
            case 7:
                cell.update(withWords: word.sixLetters, guessedWords: guessedWords.sixLetters)
            case 8:
                cell.update(withWords: word.fiveLetters, guessedWords: guessedWords.fiveLetters)
            case 9:
                cell.update(withWords: word.fourLetters, guessedWords: guessedWords.fourLetters)
            default:
                return cell
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension HintsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (frame.size.width - 40.0) / 4
        let height = (frame.size.height - 20.0) / 3
        return CGSize(width: width, height: height)
    }
}
