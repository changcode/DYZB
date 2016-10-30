//
//  PageContentView.swift
//  DYZB
//
//  Created by Chang on 10/27/16.
//
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView, progress : CGFloat, sourceIdx : Int, targetIdx : Int)
}

private let contentCellID = "cell"

class PageContentView: UIView {

    weak var delegate : PageContentViewDelegate?
    
    fileprivate var childVcs : [UIViewController]
    weak var parentVc : UIViewController?
    
    fileprivate var startOffsetX : CGFloat = 0
    
    fileprivate var isForibidScrollDelegate : Bool = false
    
    fileprivate lazy var collectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
    init(frame : CGRect, childVcs : [UIViewController], parentVc : UIViewController?) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        
        super.init(frame :frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageContentView {
    fileprivate func setupUI() {
        for childVc in childVcs {
            parentVc?.addChildViewController(childVc)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForibidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForibidScrollDelegate {
            return
        }
        
        var progress : CGFloat = 0
        var sourceIdx : Int = 0
        var targetIdx : Int = 0
        
        // judge left or right slides
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewWidth = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX { //left slides
            progress = currentOffsetX / scrollViewWidth - floor(currentOffsetX / scrollViewWidth)
            
            sourceIdx = Int(currentOffsetX / scrollViewWidth)
            targetIdx = sourceIdx + 1
            if targetIdx >= childVcs.count {
                targetIdx = childVcs.count - 1
            }
            
            if (currentOffsetX - startOffsetX)  == scrollViewWidth {
                progress = 1
                targetIdx = sourceIdx
            }
            
        } else { // right slides
            progress = 1 - ( currentOffsetX / scrollViewWidth - floor(currentOffsetX / scrollViewWidth))
            
            
            targetIdx = Int(currentOffsetX / scrollViewWidth)
            sourceIdx = targetIdx + 1
            
            if sourceIdx >= childVcs.count {
                sourceIdx = childVcs.count - 1
            }
            if (currentOffsetX - startOffsetX)  == scrollViewWidth {
                progress = 1
                sourceIdx = targetIdx
            }
            
            if abs(currentOffsetX - startOffsetX)  == scrollViewWidth {
                progress = 1
                sourceIdx = targetIdx
            }
        }
        
        
        
        delegate?.pageContentView(contentView: self, progress: progress, sourceIdx: sourceIdx, targetIdx: targetIdx)
    }
}

extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

extension PageContentView {
    public func setCurrentIndex(currentIndex : Int) {
        isForibidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y : 0), animated: false)
    }
}
