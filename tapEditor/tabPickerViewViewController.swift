//
//  tabPickerViewViewController.swift
//  tapEditor
//
//  Created by Jun Zhou on 7/28/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import UIKit

class tabPickerViewViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var mainView: UIView!
    
    let chordTypes = ["-", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
    let tabComponent = 0
    let tabContentComponent = [1, 2, 3, 4, 5, 6]
    var tabSaved: [String: [String]] = ["C": ["1", "2", "3", "4", "5", "6"], "A": ["6", "5", "4", "3", "2", "1"], "G": ["1", "2", "3", "4", "5", "6"], "F": ["6", "5", "4", "3", "2", "1"]]
    var tabKey: [String]!
    var tabContent: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nameField.text = "Tab Name"

        let tabOrigin = tabSaved.keys
        tabKey = sorted(tabOrigin)
        let selectedTab = tabKey[0]
        tabContent = tabSaved[selectedTab]
        
        for var index = 0; index < tabContentComponent.count; index++ {
            //existTabPicker.reloadComponent(index)
            let selectRow = tabContent[index].toInt()
            existTabPicker.selectRow(selectRow! + 1, inComponent: tabContentComponent[index], animated: true)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var existTabPicker: UIPickerView!

    @IBOutlet weak var newTabPicker: UIPickerView!
    
    @IBAction func modifyButton(sender: AnyObject) {
        var refreshAlert = UIAlertController(title: "Modify Tab", message: "Are you sure you want to modify the tab?", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) in
            
        }))
        
    
        refreshAlert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) in

        }))
        presentViewController(refreshAlert, animated: true, completion: nil)

    }
    @IBAction func saveButton(sender: AnyObject) {
        var refreshAlert = UIAlertController(title: "Save Tab", message: "Are you sure you want to save the tab?", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) in
            
        }))
        presentViewController(refreshAlert, animated: true, completion: nil)

    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        var refreshAlert = UIAlertController(title: "Back to Tab Editor", message: "Are you sure you want to back to Tab Editor without saving?", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) in
            
        }))
        presentViewController(refreshAlert, animated: true, completion: nil)

    }
    
    @IBAction func textFieldDuringEditing(sender: UITextField) {
        sender.text.uppercaseString
    }
    
    @IBAction func textFieldBeginEditing(sender: UITextField) {
        if sender.text == "Tab Name" {
            sender.text = ""
            self.nameField.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
        }
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        self.nameField.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
        sender.resignFirstResponder()
    }
    
    @IBAction func backgroundTap(sender: UIControl) {
        nameField.resignFirstResponder()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView.tag == 0{
            return 7
        } else {
            return 6
        }
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            if component == tabComponent {
                return tabKey.count
            } else {
                return chordTypes.count
            }
        } else {
            return chordTypes.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerView.tag == 0 {
            if component == tabComponent {
                return tabKey[row]
            } else {
                return chordTypes[row]
            }
        } else {
            return chordTypes[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            if component == tabComponent{
                let selectedTab = tabKey[row]
                tabContent = tabSaved[selectedTab]
                for var index = 0; index < tabContentComponent.count; index++ {
                    //existTabPicker.reloadComponent(index)
                    let selectRow = tabContent[index].toInt()
                    existTabPicker.selectRow(selectRow! + 1, inComponent: tabContentComponent[index], animated: true)
                }
                
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        let pickerHeight = pickerView.bounds.size.height
        return pickerHeight / 3
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let pickerWidth = pickerView.bounds.size.width
        if pickerView.tag == 0 {
            if component == tabComponent {
                return pickerWidth / 9 * 2
            } else {
                return pickerWidth / 9
            }
        } else {
            return pickerWidth / 7
        }
    }


}
