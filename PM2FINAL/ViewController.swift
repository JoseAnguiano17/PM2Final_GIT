//
//  ViewController.swift
//  PM2FINAL
//
//  Created by user201443 on 6/14/21.
//

import UIKit

class ViewController: UIViewController {
    public static var status: ViewController?
    @IBOutlet weak var onOffSwitch: UISwitch!
    
    @IBOutlet weak var labelSwitch: UILabel!
    
    @IBOutlet weak var themeSegmented: UISegmentedControl!
    @IBOutlet weak var themeLabel: UILabel!
    let userDefaults = UserDefaults.standard
    
    let onOff_key = "onOffKey"
    let themeKey = "themeKey"
    let darkTheme = "darkTheme"
    let ligthTheme = "light"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTheme()
        checkSwitchState()
    }
    
    
    public func updateTheme(){
        let theme = userDefaults.string(forKey: themeKey)
        if theme == ligthTheme {
            themeSegmented.selectedSegmentIndex = 0
            TableViewController.CONTEXTO?.changeColor(1)
            EditController.context?.changeColor(1)
            TableViewCell.context?.changeColor(1)
            view.backgroundColor = UIColor.white
            
        }else{
            themeSegmented.selectedSegmentIndex = 1
            TableViewController.CONTEXTO?.changeColor(2)
            EditController.context?.changeColor(2)
            TableViewCell.context?.changeColor(2)
            view.backgroundColor = UIColor.darkGray
        }
    }
    
    func checkSwitchState(){
        if userDefaults.bool(forKey: onOff_key) {
            onOffSwitch.setOn(true, animated: false)
            labelSwitch.text = "ON"
            themeLabel.isHidden = false
            themeSegmented.isHidden = false
        }else{
            onOffSwitch.setOn(false, animated: false)
            labelSwitch.text = "OFF"
            themeLabel.isHidden = true
            themeSegmented.isHidden = true
        }
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        switch themeSegmented.selectedSegmentIndex {
        case 0:
            userDefaults.setValue(ligthTheme, forKey: themeKey)
            TableViewController.CONTEXTO?.changeColor(1)
            EditController.context?.changeColor(1)
            TableViewCell.context?.changeColor(1)
        case 1:
            userDefaults.setValue(darkTheme, forKey: themeKey)
            TableViewController.CONTEXTO?.changeColor(2)
            EditController.context?.changeColor(2)
            TableViewCell.context?.changeColor(2)
        default:
            userDefaults.setValue(ligthTheme, forKey: themeKey)
        }
        updateTheme()
    }
    
    
    @IBAction func switchChanged(_ sender: Any){
        if(onOffSwitch.isOn) {
            userDefaults.set(true, forKey: onOff_key)
            labelSwitch.text = "ON"
            themeLabel.isHidden = false
            themeSegmented.isHidden = false
        }else{
            userDefaults.set(false, forKey: onOff_key)
            labelSwitch.text = "OFF"
            themeLabel.isHidden = true
            themeSegmented.isHidden = true
        }
    }
    
    
}
