//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by Chang on 10/30/16.
//
//

import UIKit
import Kingfisher

class CollectionNormalCell: CollectionBaseCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            
            titleLabel.text = anchor?.room_name
        }
    }
}
