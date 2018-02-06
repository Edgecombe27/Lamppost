//
//  FlyerView.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2018-02-04.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class FlyerView: UIView {

    @IBOutlet weak var contentView: UIView!
    var flyer : Flyer!
    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func customInit() {
        Bundle.main.loadNibNamed("FlyerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

    }
    
    public func render(withFlyer : Flyer) {
        flyer = withFlyer
        
        imageView.image = flyer.icon
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.midX, y: bounds.minY + layer.cornerRadius))
        path.addLine(to: CGPoint(x: bounds.maxX - layer.cornerRadius, y: bounds.midY))
        path.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY - layer.cornerRadius))
        path.addLine(to: CGPoint(x: bounds.minX + layer.cornerRadius, y: bounds.midY))
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = layer.cornerRadius * 2
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineCapRound
        
        layer.mask = shapeLayer
        
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 86, green: 22, blue: 67, alpha: 1).cgColor
        
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    

}
