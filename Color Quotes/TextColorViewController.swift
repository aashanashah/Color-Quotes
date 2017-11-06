//
//  TextColorViewController.swift
//  Color Quotes
//
//  Created by Aashana on 10/25/17.
//  Copyright © 2017 Aashana. All rights reserved.
//

import UIKit

class TextColorViewController: UIViewController, UITextFieldDelegate {
    var redBackground : Double!
    var greenBackground : Double!
    var blueBackground : Double!
    @IBOutlet var myView : UITextView!
    @IBOutlet var redSlider : UISlider!
    @IBOutlet var greenSlider : UISlider!
    @IBOutlet var blueSlider : UISlider!
    var red=0
    var blue=0
    var green=0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose Text Color"
        myView.backgroundColor = UIColor(red: CGFloat(redBackground), green: CGFloat(greenBackground), blue: CGFloat(blueBackground), alpha: 1.00)
        myView.isUserInteractionEnabled = false
        myView.layer.cornerRadius = 10
        myView.layer.borderColor = UIColor.black.cgColor
        myView.layer.borderWidth = 1
        let doneImage = UIImage(named: "done")!
        let backImage = UIImage(named: "backIcon")!
        
        let doneButton   = UIBarButtonItem(image: doneImage,  style: .plain, target: self, action: #selector(onClickDone(sender:)))
        
       let backButton = UIBarButtonItem(image: backImage,  style: .plain, target: self, action: #selector(back(sender:)))
        backButton.width = 25.0
        doneButton.width = 25.0
        navigationItem.setRightBarButton(doneButton, animated: true)
        
        navigationItem.setLeftBarButton(backButton, animated: true)
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        // Do any additional setup after loading the view.
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
        let quotesViewController = self.storyboard?.instantiateViewController(withIdentifier: "QuotesViewController") as! QuotesViewController
        quotesViewController.redText = Double(red) / 255.0
        quotesViewController.greenText = Double(green) / 255.0
        quotesViewController.blueText =  Double(blue) / 255.0
        quotesViewController.redBackground = redBackground
        quotesViewController.greenBackground = greenBackground
        quotesViewController.blueBackground =  blueBackground
        self.navigationController?.pushViewController(quotesViewController, animated: true)
    }
    @objc func back(sender : UIButton)
    {
        //self.navigationController.pop()
        self.navigationController?.popViewController(animated: true)
    }
    func changeColor()
    {
        
        let redFloat=Double(red) / 255.0
        let greenFloat=Double(green) / 255.0
        let blueFloat=Double(blue) / 255.0
        
        myView.textColor = UIColor(red: CGFloat(redFloat), green: CGFloat(greenFloat), blue: CGFloat(blueFloat), alpha: 1.00)
    }
}
