//
//  NewSaleViewController.swift
//  MyPizza
//
//  Created by Bruce on 16/11/26.
//  Copyright © 2016年 Bruce. All rights reserved.
//

import UIKit

class NewSaleViewController: UIViewController , UITextFieldDelegate{

    
    var toPass_id:String!
    var toPass_points:String!

    @IBOutlet weak var label_availabel_points: UILabel!
    @IBOutlet weak var consumedTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.consumedTextField.keyboardType = UIKeyboardType.numberPad

        consumedTextField.delegate = self
        // Do any additional setup after loading the view.
        //assignbackground()
    }

    @IBAction func consumedUpdated(_ sender: AnyObject) {
        let newPoints = Float(consumedTextField.text!)! * 100
        label_availabel_points.text = String(newPoints)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func Save(_ sender: AnyObject) {
        var a = Int(consumedTextField.text!);
        var b = Int(toPass_points);
        var newPoints = a! * 100 + b!;
        var str_newPoints = String(newPoints);
        let url = NSURL(string: "https://synctech.000webhostapp.com/newBillService.php?id="+toPass_id+"&points="+str_newPoints)
        let data = NSData(contentsOf: url as! URL)
        //let values = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        label_availabel_points.text = str_newPoints;
        

        //self.dismiss(animated: true, completion:{NSLog("Close window")});
    }
    
    func save()
    {
        var a = Int(consumedTextField.text!);
        var b = Int(toPass_points);
        
        
        var newPoints = a! * 100 + b!;
        var str_newPoints = String(newPoints);
        let url = NSURL(string: "https://synctech.000webhostapp.com/newBillService.php?id="+toPass_id+"&points="+str_newPoints)
        let data = NSData(contentsOf: url as! URL)
        label_availabel_points.text = str_newPoints;
        
        //Update redeem items
        let url_1 = NSURL(string: "https://synctech.000webhostapp.com/updatePointsService.php?id="+toPass_id+"&points="+str_newPoints)
        let data_1 = NSData(contentsOf: url_1 as! URL)
        
    }
    
    
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        save();
        if ((segue.identifier == "save_segue_new_sale_customer_details")
            ||
            (segue.identifier == "cancel_segue_new_sale_customer_details")
            ){
            let svc = segue.destination as! DetailViewController;
            
            svc.toPass = toPass_id
            
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
