//
//  InternationalNumberViewController.swift
//  WhoCallme
//
//  Created by Muhammad Imran on 16/05/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit


struct internationalPhoneNumberDetail {
    
    var location : String
    var national_number : Int
    var carrier : String
    var is_valid_number : Bool
    var location_latitude : Double
    var country_code_iso : String
    var country_code: Int
    var phone_number_e164  :String
    var number_type : String
    var location_longitude : Double
    //var number_of_leading_zeros: String
}

class InternationalNumberViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    override func viewWillAppear(_ animated: Bool) {
             
             Constants.showInterstitial(viewController: self)
         }
    var myactivityIndicator = UIActivityIndicatorView()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
    
    var arrayofDetail = [internationalPhoneNumberDetail]()
    let net = Networking()
    var callingCode : String?
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  sortedcountries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortedcountries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        net.CountryCallingCode(countryName: sortedcountries[row]) { (dict) in
            
            if let call  = dict["country-calling-code"]{
                DispatchQueue.main.async {
                    self.mytextfield.text = "+\(call)"
                    self.blurView.isHidden = true
                    self.countryPicker.isHidden = true
                }
                
                print(call)
            } else {return}
            
            
        }
        
    }
    
    @IBAction func countryCodeButton(_ sender: Any) {
        mytextfield.resignFirstResponder()
        blurView.isHidden = false
        countryPicker.isHidden = false
        blurView.isUserInteractionEnabled = true
        countryPicker.isUserInteractionEnabled = true
    }
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var mytextfield: TextFieldWithImage!
    var sortedcountries = [String]()
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var countryPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Constants.addBannerViewToView(viewController: self)
        self.navigationItem.title = "International"
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped) )
        view.addGestureRecognizer(tap)
        countryPicker.dataSource = self
        countryPicker.delegate = self
        blurView.layer.cornerRadius = 12
        innerView.layer.cornerRadius = 12
        searchButton.layer.cornerRadius = 12
        
        blurView.isHidden = true
        countryPicker.isHidden = true
        
        let countries : [String] = NSLocale.isoCountryCodes.map { (code:String) -> String in
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            return NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
        }
        sortedcountries  = countries.sorted { $0 < $1 }
        
    }
    @objc func tapped(){
        self.view.endEditing(true)
    }
    @IBAction func searchBtn(_ sender: Any) {
        if Reachability.isConnectedToNetwork(){
        if mytextfield.text?.count == 0{Alert(title: "Error", message: "Please Enter Number TextField Should Not be Empty")
            return}
        self.view.endEditing(true)
        activityIndicator("Fetching Database")
        if let number = mytextfield.text{
            
            net.NumberDetail(phoneNumber: number) { dict in
                //dump(dict)
            
                guard let location = dict["location"] else {
                    self.RemoveLoading()
                    DispatchQueue.main.async {
                        self.Alert(title: "Error", message: "Enter Correct Number with Country Code")
                    }
                    return
                }
                guard let national_number = dict["national_number"] else {
                    self.RemoveLoading()
                    DispatchQueue.main.async {
                        self.Alert(title: "Error", message: "Enter Correct Number with Country Code")
                    }
                    return
                }
                guard let carrier = dict["carrier"] else {
                    self.RemoveLoading()
                    DispatchQueue.main.async {
                        self.Alert(title: "Error", message: "Enter Correct Number with Country Code")
                    }
                    return
                }
                guard let is_valid_number = dict["is_valid_number"] else {
                    self.RemoveLoading()
                    DispatchQueue.main.async {
                        self.Alert(title: "Error", message: "Number Not Found in Database or You are Trying Wrong Number Please Enter Correct Number With Counntry Code")
                    }
                    return
                }
                guard let location_latitude = dict["location_latitude"] else {
                    self.RemoveLoading()
                    DispatchQueue.main.async {
                        self.Alert(title: "Error", message: "Enter Correct Number with Country Code")
                    }
                    return
                }
                guard let country_code_iso = dict["country_code_iso"] else {
                    self.RemoveLoading()
                    DispatchQueue.main.async {
                        self.Alert(title: "Error", message: "Enter Correct Number with Country Code")
                    }
                    return
                }
                guard let country_code = dict["country_code"] else {
                    self.RemoveLoading()
                    DispatchQueue.main.async {
                        self.Alert(title: "Error", message: "Enter Correct Number with Country Code")
                    }
                    return
                }
                guard let phone_number_e164 = dict["phone_number_e164"] else {
                    self.RemoveLoading()
                    DispatchQueue.main.async {
                        self.Alert(title: "Error", message: "Enter Correct Number with Country Code")
                    }
                    return
                }
                guard let number_type = dict["number_type"] else {
                    self.RemoveLoading()
                    DispatchQueue.main.async {
                        self.Alert(title: "Error", message: "Enter Correct Number with Country Code")
                    }
                    return
                }
                guard let location_longitude = dict["location_longitude"] else {
                    self.RemoveLoading()
                    DispatchQueue.main.async {
                        self.Alert(title: "Error", message: "Enter Correct Number with Country Code")
                    }
                    return
                }
                
                let randomDouble = Double.random(in: 1...100)
                let randomDouble1 = Double.random(in: 1...100)
   
                if country_code as! Int == 92 {
                    
                   let location_latitude  = Double.random(in: 28...34)
                   let location_longitude   = Double.random(in: 67...75)
                    let obj = internationalPhoneNumberDetail(location: location as! String, national_number: national_number as! Int, carrier: carrier as! String, is_valid_number: is_valid_number as! Bool, location_latitude: location_latitude, country_code_iso: country_code_iso as! String, country_code: country_code as! Int, phone_number_e164: phone_number_e164 as! String, number_type: number_type as! String, location_longitude: location_longitude)
                    self.arrayofDetail.append(obj)
                    
                }
                else{
                let obj = internationalPhoneNumberDetail(location: location as! String, national_number: national_number as! Int, carrier: carrier as! String, is_valid_number: is_valid_number as! Bool, location_latitude: location_latitude as? Double ?? randomDouble, country_code_iso: country_code_iso as! String, country_code: country_code as! Int, phone_number_e164: phone_number_e164 as! String, number_type: number_type as! String, location_longitude: location_longitude as? Double ?? randomDouble1)
                    self.arrayofDetail.append(obj)
                }
                dump(self.arrayofDetail)

                
                DispatchQueue.main.async {
                    self.RemoveLoading()
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "InternationDetailViewController") as! InternationDetailViewController
                    newViewController.detailArray.removeAll()
                    newViewController.detailArray = self.arrayofDetail
                    self.arrayofDetail.removeAll()
                    self.navigationController?.navigationItem.title = "Internation Dictionry"
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
                
            }
            //            ["location": Pakistan, "national_number": 3084706656, "carrier": Mobilink, "is_valid_number": 1, "location_latitude": 30.3308401, "country_code_iso": PK, "country_code": 92, "phone_number_e164": +923084706656, "number_type": MOBILE, "location_longitude": 71.247499, "number_of_leading_zeros": <null>]
            
            
        }
        else{
            return
        }
        }
        else{
            Alert(title: "Network error", message: "Please Check Your Internet Connection")
        }
        
    }
    
    
    func RemoveLoading(){
        DispatchQueue.main.async {
            self.effectView.removeFromSuperview()
        }
    }
    @IBAction func selectCountry(_ sender: UITextField) {
        
        if self.mytextfield.text != ""{
            
        }else{
            
        }
    }
    
    func Alert(title: String, message: String){
        DispatchQueue.main.async {
            self.RemoveLoading()
            self.view.shake()
             let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
             ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
 
        
    }
    
      func AlertforUnknownLocation(title: String, message: String){
           DispatchQueue.main.async {
               self.RemoveLoading()
               self.view.shake()
                let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
               self.present(ac, animated: true)
           }
    
           
       }
    
    
    func activityIndicator(_ title: String) {
        
        var strLabel = UILabel()
        strLabel.removeFromSuperview()
        myactivityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: self.view.frame.midX - strLabel.frame.width/2, y: self.view.frame.midY - strLabel.frame.height/2 , width: 220, height: 50)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        myactivityIndicator = UIActivityIndicatorView(style: .large)
        myactivityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        myactivityIndicator.color = .white
        myactivityIndicator.startAnimating()
        
        effectView.contentView.addSubview(myactivityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    
    
}
extension UIView {
    func shake(duration timeDuration: Double = 0.07, repeat countRepeat: Float = 3){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = timeDuration
        animation.repeatCount = countRepeat
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}
