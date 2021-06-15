//
//  ViewController.swift
//  PM2FINAL
//
//  Created by user201443 on 6/14/21.
//

import UIKit

class ViewController: UIViewController {
    
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
        checkSwitchState()
        updateTheme()
    }
    
    func updateTheme(){
        let theme = userDefaults.string(forKey: themeKey)
        if theme == ligthTheme {
            themeSegmented.selectedSegmentIndex = 0
            view.backgroundColor = UIColor.white
        }else{
            themeSegmented.selectedSegmentIndex = 1
            view.backgroundColor = UIColor.gray
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
        case 1:
            userDefaults.setValue(darkTheme, forKey: themeKey)
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
