//
//  CollectionBeautyCell.swift
//  DYZB
//
//  Created by Chang on 10/30/16.
//
//

import UIKit

class CollectionBeautyCell: CollectionBaseCell {

    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor : AnchorModel? {
        didSet {
           super.anchor = anchor
            
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            

        }
    }
}
