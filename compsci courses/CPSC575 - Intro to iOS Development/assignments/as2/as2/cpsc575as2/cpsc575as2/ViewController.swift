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
    
    
    @IBAction func nameLabelChange(_ nameSender: UITextField) {
        switch nameSender.text{
        case "":
            nameLabel.text = "Name has been cleared"
        default:
            nameLabel.text = "Hello, \(nameSender.text ?? "")"
        }
    }
    
    
    @IBAction func numLblChange(_ sender: Any) {
        switch numField.text{
        case "":
            numLabel.text = "Number has been cleared"
        default:
            numLabel.text = "Your number is \(numField.text ?? "0")"
        }
    }
    
    
    @IBAction func setButtonTapped(_ sender: Any) {
        numField.resignFirstResponder()
    }
    
    
    @IBAction func sliderChange(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        sliderLabel.text = "\(currentValue)"
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        nameField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func leftSwitchTapped(_ sender: UISwitch) {
        switch leftSwitch.isOn{
        case true:
            rightSwitch.setOn(true, animated: true)
        default:
            rightSwitch.setOn(false, animated: true)
        }
    }
    
    
    @IBAction func rightSwitchTapped(_ sender: UISwitch) {
        switch rightSwitch.isOn{
        case true:
            leftSwitch.setOn(true, animated: true)
        default:
            leftSwitch.setOn(false, animated: true)
        }
    }
    
    
    @IBAction func multiButtonTap(_ sender: UISegmentedControl) {
        switch multiButton.selectedSegmentIndex{
        case 0:
            leftSwitch.isHidden = false
            rightSwitch.isHidden = false
            doSomethingBtn.isHidden = true
        
        case 1:
            leftSwitch.isHidden = true
            rightSwitch.isHidden = true
            doSomethingBtn.isHidden = false
            
        default:
            break
        }
    }
    
    
    @IBAction func doSomethingTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "⚠️CRITICAL ERROR⚠️", message: "Jk lol.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

