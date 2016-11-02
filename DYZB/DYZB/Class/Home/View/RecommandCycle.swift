//
//  RecommandCycle.swift
//  DYZB
//
//  Created by Chang on 11/1/16.
//
//

import UIKit
let kCycleCellID = "kCycleCellID"
class RecommandCycle: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    public var cycleModels : [CycleModel]? {
        didSet {
            collectionView.reloadData()
            
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        
        //register cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellID)
        collectionView.showsHorizontalScrollIndicator = false
        
        //setup cell
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
    }
}

extension RecommandCycle {
    class func getRecommandCycle() -> RecommandCycle {
        return Bundle.main.loadNibNamed("RecommandCycle", owner: nil, options: nil)?.first as! RecommandCycle
    }
}

//UICollection view delegate 
extension RecommandCycle : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath)
        
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        
        
        return cell
    }
}
