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

fileprivate let kCycleViewHeight = kMainScreenWidth * 3 / 8
fileprivate let kGameViewHeight : CGFloat = 90

class RecommandViewController: UIViewController {
    
    //my collectionView lazy init
    
    fileprivate lazy var recommandCycle : RecommandCycle = {
        let recommandCycle = RecommandCycle.getRecommandCycle()
        
        recommandCycle.frame = CGRect(x: 0, y: -(kCycleViewHeight + kGameViewHeight), width: kMainScreenWidth, height: kCycleViewHeight)
        
        return recommandCycle
    }()
    
    fileprivate lazy var recommandGame: RecommendGameView = {
        let recommandGame = RecommendGameView.recommendGameView()
        recommandGame.frame = CGRect(x: 0, y: -kGameViewHeight, width: kMainScreenWidth, height: kGameViewHeight)
        
        
        return recommandGame
    }()
    
    fileprivate lazy var collectionView : UICollectionView = {  [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kItemNormalHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kMainScreenWidth, height: kHeadViewHeight)
        
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewHeight + kGameViewHeight, 0, 0, 0)
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
        

        recommandViewModel.requestDate { 
            self.collectionView.reloadData()
            self.recommandGame.games = self.recommandViewModel.anchorGroups
        }
        recommandViewModel.requestCycleDate {
            self.recommandCycle.cycleModels = self.recommandViewModel.cycleModels
            
        }
        
    }

}

// Setup UI
extension RecommandViewController {
    fileprivate func setupUI() {
        //add collectionView
        view.addSubview(collectionView)
        collectionView.addSubview(recommandCycle)
        collectionView.addSubview(recommandGame)
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
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadCellId, for: indexPath) as! HeaderCollectionReusableView
        
        headerView.group = recommandViewModel.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group = recommandViewModel.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item ]
        
        var cell : CollectionBaseCell!
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBeautyCellId, for: indexPath) as! CollectionBeautyCell
        } else {

            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath) as! CollectionNormalCell
        }
        cell.anchor =  anchor
        
        return cell
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.recommandViewModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group : AnchorGroup = self.recommandViewModel.anchorGroups[section]
        return group.anchors.count
    }
}
