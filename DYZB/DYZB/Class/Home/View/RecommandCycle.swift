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
    
    fileprivate var cycleTimer : Timer?
    
    public var cycleModels : [CycleModel]? {
        didSet {
            collectionView.reloadData()
            
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            let indexPath : IndexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            addCycleTimer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        
        //register cell
        
        collectionView.register(UINib(nibName: "RecommandCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
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
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : RecommandCycleCell!
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! RecommandCycleCell
        
        cell.cycleModel = cycleModels?[indexPath.item % (cycleModels?.count ?? 1)] ?? nil
        
        return cell
    }
}

extension RecommandCycle : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        let pageNum = Int(offset / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        self.pageControl.currentPage = pageNum
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}


extension RecommandCycle {
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    fileprivate func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc private func scrollToNext () {
        let currentOffsetX = collectionView.contentOffset.x
        let offset = currentOffsetX + collectionView.bounds.width
        
        collectionView.setContentOffset(CGPoint(x:offset, y: 0), animated: true)
    }
    
}
