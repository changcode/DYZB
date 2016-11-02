//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by Chang on 11/1/16.
//
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    //property
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var watchingBtn: UIButton!
    @IBOutlet weak var liveImage: UIImageView!
    
    var anchor : AnchorModel? {
        didSet {
            guard let anchor = anchor else {
                return
            }
            
            var onlineStr : String = ""
            if anchor.online >= 1000 {
                onlineStr = "\(Int(anchor.online / 1000))K online"
            } else {
                onlineStr = "\(anchor.online) online"
            }
            
            
            nicknameLabel.text = anchor.nickname
            
            watchingBtn.setTitle(onlineStr, for: .normal)
            
            
            guard let url = URL(string: (anchor.vertical_src)) else { return }
            liveImage.kf.setImage(with: url)
        }
    }

}
