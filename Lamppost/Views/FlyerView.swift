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
        
        self.layer.cornerRadius = 50
        self.layer.masksToBounds = true
        
    }
    
    public func render(withFlyer : Flyer) {
        flyer = withFlyer
        
        imageView.image = flyer.icon
        
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    

}
