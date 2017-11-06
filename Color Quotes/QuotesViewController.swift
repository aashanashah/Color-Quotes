//
//  QuotesViewController.swift
//  Color Quotes
//
//  Created by Aashana on 10/25/17.
//  Copyright © 2017 Aashana. All rights reserved.
//

import UIKit

class QuotesViewController: UIViewController, UITextViewDelegate  {
    var redText : Double!
    var greenText : Double!
    var blueText : Double!
    var redBackground : Double!
    var greenBackground : Double!
    var blueBackground : Double!
    var complete : Bool!
    @IBOutlet var textView : UITextView!
    @IBOutlet var fontSlider : UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Quote"

        textView.delegate = self
        textView.backgroundColor = UIColor(red: CGFloat(redBackground), green: CGFloat(greenBackground), blue: CGFloat(blueBackground), alpha: 1.00)
        textView.textColor = UIColor(red: CGFloat(redText), green: CGFloat(greenText), blue: CGFloat(blueText), alpha: 1.00)
        textView.text=UserDefaults.standard.string(forKey: "StoreText")
        let shareImage   = UIImage(named: "share")!
        //let saveImage = UIImage(named: "save")!
        let backImage = UIImage(named: "backIcon")!

        
        let shareButton   = UIBarButtonItem(image: shareImage,  style: .plain, target: self, action: #selector(share(sender:)))
        //let saveButton = UIBarButtonItem(image: saveImage,  style: .plain, target: self, action: #selector(save(sender:)))
        let backButton = UIBarButtonItem(image: backImage,  style: .plain, target: self, action: #selector(back(sender:)))
        shareButton.width = 25.0
        //saveButton.width = 25.0
        backButton.width = 25.0

        navigationItem.setRightBarButton(shareButton, animated: true)
        navigationItem.setLeftBarButton(backButton, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        
        self.addDoneButtonOnKeyboard()
        if textView.text != nil
        {
            fontSlider.value = UserDefaults.standard.float(forKey: "StoreSize")
            textView.font = UIFont(name: (textView.font?.fontName)!, size: CGFloat(UserDefaults.standard.float(forKey: "StoreSize")))
        }
        else
        {
            fontSlider.value = 0.0
        }
    }
    override func viewDidAppear(_ animated: Bool)
    {
        textView.becomeFirstResponder()
    }
    
    @objc func share(sender : UIButton)
    {
        print("Share")
        let img = textViewImage()
        let shareItem = [img]
        let activityController = UIActivityViewController(activityItems: shareItem, applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
        activityController.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems:[Any]?, error: Error?) in
            self.complete = completed
            self.checkstatus()
        }
        
    }
    func checkstatus()
    {
        if complete == true
        {
            UserDefaults.standard.set(textView.text, forKey: "StoreText")
            textView.text = ""
        }
    }
    @objc func back(sender : UIButton)
    {
        //self.navigationController.pop()
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(QuotesViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.textView.inputAccessoryView = doneToolbar
    }
    @objc func doneButtonAction()
    {
        self.view.endEditing(true)
        UserDefaults.standard.set(textView.text, forKey: "StoreText")
        textView.resignFirstResponder()
    }
    func textViewImage() -> UIImage {
        
        var image: UIImage? = nil
        
        UIGraphicsBeginImageContextWithOptions(textView.contentSize, textView.isOpaque, 0.0)
        
        textView.contentOffset = CGPoint(x:0, y:0)
        
        textView.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:450)
        
        textView.layer.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
    @IBAction func SliderChanged(sender : UISlider)
    {
        let size = Int(sender.value)
        textView.font = UIFont(name: (textView.font?.fontName)!, size: CGFloat(size))
        UserDefaults.standard.set(textView.font?.pointSize, forKey: "StoreSize")
    }
    

}
