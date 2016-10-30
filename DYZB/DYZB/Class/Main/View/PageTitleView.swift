//
//  PageTitle.swift
//  DYZB
//
//  Created by Chang on 10/27/16.
//
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index: Int)
}

fileprivate let scrollLineHeight : CGFloat = 3

fileprivate let kDarkGreyColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
fileprivate let kOrangeColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {
    
    //custum vars
    fileprivate var selectLabelIndex : Int = 0
    
    fileprivate var titles : [String]
    fileprivate var titleLabels : [UILabel] = [UILabel]()
    
    
    weak var delegate : PageTitleViewDelegate?
    
    //lazy init scrollview
    fileprivate lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
        
    }()
    
    fileprivate lazy var buttomScrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
    }()
    
    
    //make custom init
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension PageTitleView {
    fileprivate func setupUI() {
        addSubview(scrollView)
        
        scrollView.frame = bounds
        
        setupTitleLabels()
        
        setupButtomLine()
    }
    
    private func setupTitleLabels() {
        
        
        
        for(index, title) in titles.enumerated() {
            //create label
            let label = UILabel()
            
            //setup label property
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kDarkGreyColor.0, g: kDarkGreyColor.1, b: kDarkGreyColor.2)
            label.textAlignment = .center
            
            //set label frame
            let labelWidth: CGFloat = frame.width / CGFloat(titles.count)
            let labelHeight: CGFloat = frame.height - scrollLineHeight
            let labelX: CGFloat = labelWidth * CGFloat(index)
            let labelY: CGFloat = 0
            label.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
            
            
            //add label to scrollView
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //add gestrure to label
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
        }
    }
    
    private func setupButtomLine() {
        
        // add buttom fixed-line
        let buttomLine = UIView()
        let buttomLineHeight : CGFloat = 0.5
        
        buttomLine.backgroundColor = UIColor.lightGray
        
        buttomLine.frame = CGRect(x: 0, y: frame.height - buttomLineHeight, width: frame.width, height: buttomLineHeight)
        addSubview(buttomLine)
        
        // add buttom scroll-line
        
        guard let firstLabel = titleLabels.first else {
            return
        }
        
        firstLabel.textColor = UIColor(r: kOrangeColor.0, g: kOrangeColor.1, b: kOrangeColor.2)
        
        buttomScrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - scrollLineHeight - buttomLineHeight, width: firstLabel.frame.width, height: scrollLineHeight)
        scrollView.addSubview(buttomScrollLine)
    }
}

extension PageTitleView {
    @objc fileprivate func titleLabelClick(tapGes : UITapGestureRecognizer) {
        
        guard let selLabel = tapGes.view as? UILabel else { return }
        
        
        let preLabel = titleLabels[selectLabelIndex]
        
        preLabel.textColor = UIColor.darkGray
        selLabel.textColor = UIColor.orange
        
        
        selectLabelIndex = selLabel.tag
        
        let scrollLinePositionX = CGFloat(selLabel.tag) * buttomScrollLine.frame.width
        UIView.animate(withDuration: 0.15, delay: 0.15, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.3, options: .transitionFlipFromLeft, animations: {
             self.buttomScrollLine.frame.origin.x = scrollLinePositionX
            }, completion: nil)
        
        delegate?.pageTitleView(titleView: self, selectedIndex: selectLabelIndex)
        
    }
}


extension PageTitleView {
    public func setTitleWithPorgress(progress : CGFloat, sourceIdx : Int, targetIdx : Int) {
        //get source label and target label
        let sourceLabel = titleLabels[sourceIdx]
        let targetLabel = titleLabels[targetIdx]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = progress * moveTotalX
        buttomScrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        let colorDelta = (kOrangeColor.0 - kDarkGreyColor.0, kOrangeColor.1 - kDarkGreyColor.1, kOrangeColor.2 - kDarkGreyColor.2)
        
        sourceLabel.textColor = UIColor(r: kOrangeColor.0 - colorDelta.0 * progress, g: kOrangeColor.1 - colorDelta.1 * progress, b: kOrangeColor.2 - colorDelta.2 * progress)
        targetLabel.textColor = UIColor(r: kDarkGreyColor.0 + colorDelta.0 * progress, g: kDarkGreyColor.1 + colorDelta.1 * progress, b: kDarkGreyColor.2 + colorDelta.2 * progress)
        
        selectLabelIndex = targetIdx
    }
}
