//
//  EditCustomerViewController.swift
//  MyPizza
//
//  Created by Bruce on 16/11/29.
//  Copyright © 2016年 Bruce. All rights reserved.
//

import UIKit

class EditCustomerViewController: UIViewController {
    
    var toPass_id:String!

    @IBOutlet weak var datePicker_birthday: UIDatePicker!
    @IBOutlet weak var label_points: UILabel!
    @IBOutlet weak var textField_postcode: UITextField!
    @IBOutlet weak var textField_email: UITextField!

    @IBOutlet weak var textField_telephone: UITextField!
    @IBOutlet weak var textField_id: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
        

        // Do any additional setup after loading the view.
        //assignbackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func get()
    {
        //let url = NSURL(string: "http://192.168.0.17/service.php?id="+toPass_id)
        let url = NSURL(string: "https://synctech.000webhostapp.com/service.php?id="+toPass_id)
        
        let data = NSData(contentsOf: url as! URL)
        let values = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        
        let telephone = values["tel"]
        let id = values["id"]
        let postcode = values["postcode"]
        let email = values["email"]
        let points = values["points"]
        let birthday = values["birthday"]
        textField_id.text = toPass_id
        textField_telephone.text = telephone as! String
        textField_postcode.text = postcode as! String
        textField_email.text = email as! String
        label_points.text = points as! String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        //dateFormatter.dateStyle = DateFormatter.Style
        
        //bruce test
        
        var str = birthday! as! String;
        var dateObj = dateFormatter.date(from: birthday! as! String)
        if(dateObj == nil)
        {
            let dateFormatter_1 = DateFormatter()
            dateFormatter_1.dateFormat = "yyyy-MM-dd"
            let dateObj_1 = dateFormatter_1.date(from: str)
            dateObj = dateObj_1
        }

        
            datePicker_birthday.date = dateObj!
            
        
    }
    
    func save()
    {
        let customer_id = textField_id.text!;
        let postcode = textField_postcode.text!;
        let email = textField_email.text!;
        let telephone = textField_telephone.text!;
        let points = label_points.text!;
        
        let birthday_date = datePicker_birthday.date;
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat = "MM/dd/yy"
        
        let birthday = dateformatter.string(from: birthday_date)
        
        
        if(toPass_id != textField_id.text)
        {
            var myUrl = NSURL(string:"https://synctech.000webhostapp.com/newCustomerService.php?customer_id="+customer_id+"&postcode="+postcode+"&email="+email+"&telephone="+telephone+"&points="+points+"&birthday="+birthday);
            
            _ = NSData(contentsOf: myUrl as! URL)


        }
        else
        {
            var myUrl = NSURL(string:"https://synctech.000webhostapp.com/updateCustomerService.php?customer_id="+customer_id+"&postcode="+postcode+"&email="+email+"&telephone="+telephone+"&points="+points+"&birthday="+birthday);
            
            _ = NSData(contentsOf: myUrl as! URL)

        }
        
        
    }

    open override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        save();
        /*
        if ((segue.identifier == "save_segue_edit_customer_details")
            ||
            (segue.identifier == "cancel_segue_edit_customer_details")
            ){
            let svc = segue.destination as! DetailViewController;
            
            svc.toPass = toPass_id
            
        }
 */
        
        let svc = segue.destination as! DetailViewController;
        
        svc.toPass = toPass_id
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

}
