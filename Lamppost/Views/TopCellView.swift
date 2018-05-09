//
//  TopCellView.swift
//  kiOSK
//
//  Created by Spencer Edgecombe on 2018-05-09.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class TopCellView: UITableViewCell {

    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var toolBarView: UIView!
    static let NIB_NAME = "TopCellView"
    static let IDENTIFIER = "top_cell"
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var selectButton: UIButton!
    var viewController : ViewController!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        toolBarView.layer.cornerRadius = 10
        toolBarView.layer.masksToBounds = true
        
        let date = Date()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        dateLabel.text = formatter.string(from: date)
        
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        
        timeLabel.text = formatter.string(from: date)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            self.timeLabel.text = formatter.string(from: now)
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            self.dateLabel.text = formatter.string(from: date)
        }
        
        // Initialization code
        
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        viewController.addButtonPressed()
    }
    
    @IBAction func selectButtonPressed(_ sender: Any) {
        viewController.editButtonPressed()
        if selectButton.titleLabel?.text == "select" {
            selectButton.setTitle("done", for: .normal)
            deleteButton.isHidden = false
        } else {
            selectButton.setTitle("select", for: .normal)
            deleteButton.isHidden = true
        }
    }
    
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        viewController.deleteButtonPressed()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
