//
//  RecommandViewController.swift
//  DYZB
//
//  Created by Chang on 10/30/16.
//
//

import UIKit

fileprivate let kItemMargin : CGFloat = 10
fileprivate let kItemWidth = (kMainScreenWidth - 3 * kItemMargin) / 2

fileprivate let kItemNormalHeight = kItemWidth * 3 / 4
fileprivate let kItemBeautyHeight = kItemWidth * 4 / 3

fileprivate let kBeautyCellId = "kBeautyCellId"
fileprivate let kNormalCellId = "kNormalCellId"


fileprivate let kHeadViewHeight : CGFloat = 50
fileprivate let kHeadCellId = "kHeadCellId"

class RecommandViewController: UIViewController {
    
    //my collectionView lazy init
    fileprivate lazy var collectionView : UICollectionView = {  [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kItemNormalHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kMainScreenWidth, height: kHeadViewHeight)
        
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor.white
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellId)
        collectionView.register(UINib(nibName: "CollectionBeautyCell", bundle: nil), forCellWithReuseIdentifier: kBeautyCellId)
        collectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeadCellId)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    fileprivate lazy var recommandViewModel = RecommandViewModel()
    
    //System callback
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup UI
        setupUI()
        

        recommandViewModel.requestDate()
        
    }

}

// Setup UI
extension RecommandViewController {
    fileprivate func setupUI() {
        //add collectionView
        view.addSubview(collectionView)
    }
}

extension RecommandViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemWidth, height: kItemBeautyHeight)
        }
        return CGSize(width: kItemWidth, height: kItemNormalHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadCellId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell!
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBeautyCellId, for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath)
        }
            
        
        return cell
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        } else {
            return 4
        }
    }
}
