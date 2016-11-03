//
//  RecommandCycleCell.swift
//  DYZB
//
//  Created by Chang on 11/2/16.
//
//

import UIKit
import Kingfisher

class RecommandCycleCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    public var cycleModel : CycleModel? {
        didSet {
            if let cm = cycleModel {
                let iconURL = URL(string: cm.pic_url )
                iconImage.kf.setImage(with: iconURL)
                titleLabel.text = cm.title
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
