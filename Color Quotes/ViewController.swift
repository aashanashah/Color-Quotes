//
//  ViewController.swift
//  Color Quotes
//
//  Created by Aashana on 10/25/17.
//  Copyright © 2017 Aashana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var redSlider : UISlider!
    @IBOutlet var greenSlider : UISlider!
    @IBOutlet var blueSlider : UISlider!
    @IBOutlet var colorView : UIView!
    var red = 0
    var green = 0
    var blue = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose Background Color"
        colorView.layer.cornerRadius = 10
        colorView.layer.borderColor = UIColor.black.cgColor
        colorView.layer.borderWidth = 2
        let doneImage = UIImage(named: "done")!
        
        let doneButton   = UIBarButtonItem(image: doneImage,  style: .plain, target: self, action: #selector(onClickDone(sender:)))
        
        doneButton.width = 25.0
        navigationItem.setRightBarButton(doneButton, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SliderChanged(sender : UISlider)
    {
        if sender == redSlider
        {
            red = Int(sender.value)
        }
        if sender == blueSlider
        {
            blue = Int(sender.value)
        }
        if sender == greenSlider
        {
            green = Int(sender.value)
        }
        changeColor()
    }
    @objc func onClickDone(sender: UIButton)
    {
        let textColorViewController = self.storyboard?.instantiateViewController(withIdentifier: "TextColorViewController") as! TextColorViewController
        textColorViewController.redBackground = Double(red) / 255.0
        textColorViewController.greenBackground = Double(green) / 255.0
        textColorViewController.blueBackground =  Double(blue) / 255.0
        self.navigationController?.pushViewController(textColorViewController, animated: true)
    }
    func changeColor()
    {
    
        let redFloat=Double(red) / 255.0
        let greenFloat=Double(green) / 255.0
        let blueFloat=Double(blue) / 255.0
    
        colorView.backgroundColor = UIColor(red: CGFloat(redFloat), green: CGFloat(greenFloat), blue: CGFloat(blueFloat), alpha: 1.00)
    }
}

