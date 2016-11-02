//
//  HeaderCollectionReusableView.swift
//  DYZB
//
//  Created by Chang on 10/30/16.
//
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            icon.image = UIImage(named: group?.icon_name ?? "home_header_phone")
        }
    }
}
