//
//  RecommendGameView.swift
//  DYZB
//
//  Created by Chang on 11/3/16.
//
//

import UIKit

let kCollectionGameCellID = "kCollectionGameCellID"
class RecommendGameView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var games : [AnchorGroup]? {
        didSet {
            games?.removeFirst()
            games?.removeFirst()
            
            self.collectionView.reloadData()
            
        }
    }
    

    
    override func awakeFromNib() {
        self.autoresizingMask = UIViewAutoresizing()
        
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kCollectionGameCellID)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }

}

extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView : UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gameModel = games?[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.anchorGroup = gameModel
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.games?.count ?? 0;
    }
    
    
}
