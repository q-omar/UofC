//
//  ViewController.swift
//  cpsc575as2
//
//  Created by Omar Qureshi on 2018-09-29.
//  Copyright © 2018 Omar Qureshi. All rights reserved.

// Limitation: Since the professor mentioned on slack that we don't need to consider landscape mode,
// I put a restriction so that rotation will display portrait view.


import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numField: UITextField!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var leftSwitch: UISwitch!
    @IBOutlet weak var rightSwitch: UISwitch!
    
    @IBOutlet weak var multiButton: UISegmentedControl!
    @IBOutlet weak var doSomethingBtn: UIButton!
    
    
    /* this function executes once the the name textfield is deselected, either by selecting done or selecting another textfield,
    then it updates the name label with the name field value*/
    @IBAction func nameLabelChange(_ nameSender: UITextField) {
        switch nameSender.text{
        case "":
            nameLabel.text = "Name has been cleared"
        default:
            nameLabel.text = "Hello, \(nameSender.text ?? "")"
        }
    }
    
    /*this function executes once the set number button is tapped, changing the number label with value in number field*/
    @IBAction func numLblChange(_ sender: UITextField) {
        switch numField.text{
        case "":
            numLabel.text = "Number has been cleared"
        default:
            numLabel.text = "Your number is \(numField.text ?? "0")"
        }
    }
    
    /*dismisses the keypad*/
    @IBAction func setButtonTapped(_ sender: Any) {
        numField.resignFirstResponder()
    }
    
    /*this function is executed when the slider is moved, updates the slider label*/
    @IBAction func sliderChange(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        sliderLabel.text = "\(currentValue)"
    }
    
    /*ensures the namefield textfield is returned when pressing done*/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        nameField.resignFirstResponder()
        return true
    }
    
    /*this function executes when left switch is tapped, it makes sure to change the right switches state too*/
    @IBAction func leftSwitchTapped(_ sender: UISwitch) {
        switch leftSwitch.isOn{
        case true:
            rightSwitch.setOn(true, animated: true)
        default:
            rightSwitch.setOn(false, animated: true)
        }
    }
    
    /*this function executes when right switch is tapped, it makes sure to change the left switches state too*/
    @IBAction func rightSwitchTapped(_ sender: UISwitch) {
        switch rightSwitch.isOn{
        case true:
            leftSwitch.setOn(true, animated: true)
        default:
            leftSwitch.setOn(false, animated: true)
        }
    }
    
    /*the multibutton is the segmented button. If it's in case 0, the switch buttons are shwon and dosomething button is hidden.
    if it's in case 1, the switch buttons are hidden and the do something button is shown*/
    @IBAction func multiButtonTap(_ sender: UISegmentedControl) {
        switch multiButton.selectedSegmentIndex{
        case 0: //switch
            leftSwitch.isHidden = false
            rightSwitch.isHidden = false
            doSomethingBtn.isHidden = true
        
        case 1://button
            leftSwitch.isHidden = true
            rightSwitch.isHidden = true
            doSomethingBtn.isHidden = false
        default:
            break
        }
    }
    
    /*do something button creates an alert*/
    @IBAction func doSomethingTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "⚠️CRITICAL ERROR⚠️", message: "Jk lol.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

}

