//
//  NewCustomerViewController.swift
//  MyPizza
//
//  Created by YTT on 16/11/26.
//  Copyright © 2016年 YTT. All rights reserved.
//

import UIKit

class NewCustomerViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var textField_customerId: UITextField!
    @IBOutlet weak var textField_telephone: UITextField!
    @IBOutlet weak var textField_email: UITextField!
    @IBOutlet weak var textField_postcode: UITextField!
    @IBOutlet weak var textField_points: UITextField!
    @IBOutlet weak var datePicker_birthday: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField_customerId.keyboardType = UIKeyboardType.numberPad
        self.textField_telephone.keyboardType = UIKeyboardType.phonePad
        self.textField_email.keyboardType = UIKeyboardType.emailAddress
        self.textField_points.keyboardType = UIKeyboardType.decimalPad
        

        textField_customerId.delegate = self
        textField_telephone.delegate = self
        // Do any additional setup after loading the view.
        //assignbackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func save()
    {
        let customer_id = textField_customerId.text!;
        let postcode = textField_postcode.text!;
        let email = textField_email.text!;
        let telephone = textField_telephone.text!;
        let points = textField_points.text!;
        
        let birthday_date = datePicker_birthday.date;
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat = "MM/dd/yy"
        
        let birthday = dateformatter.string(from: birthday_date)
        
        
        var testUrl = NSURL(string:"https://synctech.000webhostapp.com/newCustomerService.php?birthday="+birthday);
        
        
        var myUrl = NSURL(string:"https://synctech.000webhostapp.com/newCustomerService.php?customer_id="+customer_id+"&postcode="+postcode+"&email="+email+"&telephone="+telephone+"&points="+points+"&birthday="+birthday);
        
        
        //let url = NSURL(string: "http://192.168.0.17/newCustomerService.php?customer_id="+customer_id+"&postcode="+postcode+"&email="+email+"&telephone="+telephone+"&points="+points+"&birthday="+birthday
        //);
         _ = NSData(contentsOf: myUrl as! URL)
        //self.dismiss(animated: true, completion:{NSLog("Close window")});
        
        //Update redeem items
        let url_1 = NSURL(string: "https://synctech.000webhostapp.com/updatePointsService.php?id="+customer_id+"&points="+points)
        let data_1 = NSData(contentsOf: url_1 as! URL)

        
    }
    
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        save();
        if ((segue.identifier == "save_segue_new_customer_home")
            ||
            (segue.identifier == "cancel_segue_new_customer_home")
            ){
            //let svc = segue.destination as! DetailViewController;
            
            //svc.toPass = toPass_id
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func assignbackground(){
        let background = UIImage(named: "background")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }

}
