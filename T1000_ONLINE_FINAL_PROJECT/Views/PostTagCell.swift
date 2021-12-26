//
//  PostTagCell.swift
//  T1000_ONLINE_FINAL_PROJECT
//
//  Created by يعرُب on 18/05/1443 AH.
//

import UIKit

class PostTagCell: UICollectionViewCell {
    @IBOutlet weak var tagNameLabel: UILabel!
    
    @IBOutlet weak var backView: UIView!{
        didSet{
            backView.layer.cornerRadius = 8
        }
    }
}
