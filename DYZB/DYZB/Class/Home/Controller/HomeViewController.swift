//
//  HomeViewController.swift
//  DYZB
//
//  Created by Chang on 10/27/16.
//
//

import UIKit
private let kTitleViewHeight : CGFloat = 40
class HomeViewController: UIViewController {
    
    fileprivate lazy var pageTitleView : PageTitleView = { [weak self] in
        let tittleFrame = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight, width: kMainScreenWidth, height: kTitleViewHeight)
        let titles = ["1","2","3","4"]
        let titleView = PageTitleView(frame: tittleFrame, titles: titles)
        
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = {  [weak self] in
        let contentH = kMainScreenHeigth - kStatusBarHeight - kNavigationBarHeight - kTitleViewHeight - kTabBarHeight
        let contentFrame = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight + kTitleViewHeight, width: kMainScreenWidth, height: contentH)
        
        var childVcs = [UIViewController]()
        childVcs.append(RecommandViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        
    }
}



extension HomeViewController {
    
    func setupUI() {
        //NOT setup scroll inside insets
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
        
//        pageContentView.backgroundColor = UIColor.red
    }
    
    func setupNavigationBar() {
        //left item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", hilightdImageName: "", size: CGSize.zero)
        
        //right item
        let size = CGSize(width: 40, height: 40)
        let searchBtn = UIBarButtonItem(imageName: "btn_search", hilightdImageName:"btn_search_clicked", size: size)
        let qrCodeBtn = UIBarButtonItem(imageName: "Image_scan", hilightdImageName: "Image_scan_click", size: size)
        let historyBtn = UIBarButtonItem(imageName: "image_my_history", hilightdImageName:"Image_my_history_click", size: size)
        
        navigationItem.rightBarButtonItems = [searchBtn, qrCodeBtn, historyBtn]
        
    }
}

extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}


extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIdx: Int, targetIdx: Int) {
        pageTitleView.setTitleWithPorgress(progress: progress, sourceIdx: sourceIdx, targetIdx: targetIdx)
    }
}
