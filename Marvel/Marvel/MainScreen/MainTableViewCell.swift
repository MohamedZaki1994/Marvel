//
//  MainTableViewCell.swift
//  Marvel
//
//  Created by Mohamed Mahmoud Zaki on 12/26/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {


    @IBOutlet weak var carrierView: UIView!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var labelText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        carrierView.maskCorners(inset: 15)
    }

}

extension UIView {
    func maskCorners(inset: CGFloat) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.maxX, y: 0))
        path.addLine(to: CGPoint(x: bounds.maxX - inset,y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX + inset, y: bounds.minY))
        path.close()
        let mask = CAShapeLayer()
        mask.frame = bounds
        mask.path = path.cgPath
        layer.mask = mask
    }
}
