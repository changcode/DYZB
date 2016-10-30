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
fileprivate let kItemHeight = kItemWidth * 3 / 4

fileprivate let kNormalCellId = "kNormalCellId"


fileprivate let kHeadViewHeight : CGFloat = 50
fileprivate let kHeadCellId = "kHeadCellId"

class RecommandViewController: UIViewController {
    
    //my collectionView lazy init
    fileprivate lazy var collectionView : UICollectionView = {  [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kItemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kMainScreenWidth, height: kHeadViewHeight)
        
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeadCellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellId)
        
        
        collectionView.backgroundColor = UIColor.blue
        collectionView.dataSource = self
        return collectionView
    }()
    
    //System callback
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup UI
        setupUI()
        
        
    }

}

// Setup UI
extension RecommandViewController {
    fileprivate func setupUI() {
        //add collectionView
        view.addSubview(collectionView)
    }
}

extension RecommandViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadCellId, for: indexPath)
        cell.backgroundColor = UIColor.yellow
        
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath)
        cell.backgroundColor = UIColor.red
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
