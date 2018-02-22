//
//  SettingsViewController.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/22/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    var viewController : ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        let preference = UserData.getSortPrefernece()
        
        if preference == UserData.LAST_NAME {
            pickerView.selectRow(1, inComponent: 0, animated: false)
        }
        
    }

    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 { return "First Name"}
        else { return "Last Name" }
    }
    
    @IBAction func exitViewTapped(_ sender: Any) {
        viewController.blurrView.isHidden = true
        self.dismiss(animated: true, completion: {
            
        })
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        if pickerView.selectedRow(inComponent: 0) == 0{
            UserData.setSortPreference(preference: UserData.FIRST_NAME)
        } else {
            UserData.setSortPreference(preference: UserData.LAST_NAME)
        }
        
        viewController.renderContacts()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
