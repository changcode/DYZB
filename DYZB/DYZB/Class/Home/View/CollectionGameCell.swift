//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by Chang on 11/3/16.
//
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameIcon: UIImageView!
    public var anchorGroup : AnchorGroup? {
        didSet {
            self.gameTitle.text = anchorGroup?.tag_name ?? ""
            
            if let url = URL(string: anchorGroup?.icon_url ?? "") {
                self.gameIcon.kf.setImage(with: url)
            }
            else {
                self.gameIcon.image = UIImage(named: "btn_v_more")
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
