//
//  NoteCollectionViewCell.swift
//  HandTempo
//
//  Created by Ryan on 2017/9/23.
//  Copyright © 2017年 Hanyu. All rights reserved.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell
{
    class var cellID: String
    {
        return String(describing: self)
    }
    
    @IBOutlet var labelNote: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect)
    {
        let view = UIView.init(frame: rect)
        view.backgroundColor = .white
        backgroundView = view
        
        let selectedView = UIView.init(frame: rect)
        selectedView.backgroundColor = .cyan
        selectedBackgroundView = selectedView
    }

}
