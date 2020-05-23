//
//  ViewController.swift
//  WhoCallme
//
//  Created by Muhammad Imran on 30/04/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import WebKit
import SwiftSoup
import ContactsUI
import CoreData

struct Detail {
    var name: String
    var cninc : String
    var number : String
    var address : String
    var address1 : String
    var city : String
    var region : String
    var msDate: String
    var statusDate : String
}
 
class ViewController: UIViewController,WKNavigationDelegate {
    override func viewWillAppear(_ animated: Bool) {
            Constants.showInterstitial(viewController: self)
         }
    var history = [NSManagedObject]()
    var detailArray = [Detail]()
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var innerView: UIView!
    var counter = 10
    private let contactPicker = CNContactPickerViewController()
    @IBOutlet weak var searchButton: UIButton!
    var arrayofData = [String]()
    var arrayodDetail =  [Detail]()
    @IBOutlet weak var mywebview: WKWebView!
    @IBOutlet weak var mytextFeild: UITextField!
    var number : String!
    
    var myactivityIndicator = UIActivityIndicatorView()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
    
    
    @IBAction func myButton(_ sender: Any) {
        if Reachability.isConnectedToNetwork(){
        guard let text = mytextFeild.text else{return}
       let mynumber = text.trimmingCharacters(in: .whitespaces)
        if mynumber.count == 10 {
            self.view.endEditing(true)
            self.webView = WKWebView()
               activityIndicator("Fetching Database")
               number = mytextFeild.text
               self.mywebview.isHidden = true
               self.mywebview.navigationDelegate = self
               let url = self.strUrl
               self.mywebview.load(URLRequest(url: url))
            self.mywebview.allowsBackForwardNavigationGestures = true
            
               
        }
        else{
            Alert(title: "Error", message: "Enter Correct Number without 0 and Without Spaces Only Pakistan Numbers")
        }
        }
        else{
            Alert(title: "Network error", message: "Please Check Your Internet Connection")
                }
        
   
        
    }
    var indicator  = UIActivityIndicatorView()
    var strUrl:URL =  URL(string: "https://allnumber.site")!
    var strTitle = ""
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         Constants.addBannerViewToView(viewController: self)
        innerView.layer.cornerRadius = 15
        searchButton.layer.cornerRadius = 12
        
//        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
        view.addGestureRecognizer(tap)
        
    }
//    @objc func KeyboardWillShow(sender: NSNotification){
//
//        let keyboardSize : CGSize = ((sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size)!
//        if self.view.frame.origin.y == 0{
//            self.view.frame.origin.y -= keyboardSize.height
//        }
//
//    }
//
//    @objc func KeyboardWillHide(sender : NSNotification){
//
//        let keyboardSize : CGSize = ((sender.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size)!
//        if self.view.frame.origin.y != 0{
//            self.view.frame.origin.y += keyboardSize.height
//        }
//
//    }
//       override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
    
//    @objc func updateCounter() {
//         //example functionality
//         if counter > 0 {
//             print("\(counter) seconds to the end of the world")
//             counter -= 1
//            DispatchQueue.main.async {
//                self.effectView.removeFromSuperview()
//            }
//            self.activityIndicator("Fetching Database")
//
//
//
//         }
//     }
    
    
    @objc func taped(){
        self.view.endEditing(true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            webView.evaluateJavaScript("document.getElementById('number').value = '\( self.number!)'")  { (result, error) in
                if let result = result {
                    print(result)
            webView.evaluateJavaScript("document.getElementById('search').click()")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        webView.evaluateJavaScript("document.body.innerHTML") { innerHTML, error in
                            self.DataParse(html: innerHTML as! String)
                        }
                    }
                    
                }
                else{
                    print(error?.localizedDescription ?? "Error")
                }
            }
        }
    }
    func DataParse(html : String){
        
        do{
//            self.indicator.stopAnimating()
            DispatchQueue.main.async {
                self.effectView.removeFromSuperview()
            }
            // let doc = try SwiftSoup.parse(htmlContent as! String)
            let doc : Document = try SwiftSoup.parse(html)
            // let element = try doc.select("tbody").first() // just comenting it change the name of variable to make it more clear

            let tableBody = try doc.select("tbody").first()
            guard  let allRows = try tableBody?.select("tr").array() else{return} // This will give you all rows from your HTML Table
            dump(allRows)
            var text  = String()
            for rowElement in allRows { // iterate through each row now
                // this will give you each row
                let rowEntries = try rowElement.select("td").array() // this will give you array of all entrie of single row
                
                for rowEntry in rowEntries {
                    text = try rowEntry.text() // this will give you single data entry in a particular row
                    if text != ""{
                    print(text)
                    arrayofData.append(text)
                    
                    }
                        
                    else{
                        arrayofData.append("?")
                    }
                    
                }
                let obj = Detail(name: arrayofData[0], cninc: arrayofData[1], number: arrayofData[2], address: arrayofData[3], address1: arrayofData[4], city: arrayofData[5], region: arrayofData[6], msDate: arrayofData[7], statusDate: arrayofData[8])
                arrayodDetail.append(obj)
                print(arrayodDetail.count)
                
            }
            DispatchQueue.main.async {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                newViewController.detailArray = self.arrayodDetail
                self.navigationController?.pushViewController(newViewController, animated: true)
                self.arrayofData.removeAll()
                self.arrayodDetail.removeAll()
              
            }
        }
        catch let error
        {
            print(error.localizedDescription)
            
        }
        
    }
    @IBAction func openContacts(_ sender: UIBarButtonItem) {
        contactPicker.delegate = self
        self.present(contactPicker, animated: true, completion: nil)
    }
    

    
}


extension ViewController : CNContactPickerDelegate {

    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let phoneNumberCount = contact.phoneNumbers.count

        guard phoneNumberCount > 0 else {
            dismiss(animated: true)
            //show pop up: "Selected contact does not have a number"
            return
        }

        if phoneNumberCount == 1 {
            setNumberFromContact(contactNumber: contact.phoneNumbers[0].value.stringValue)

        } else {
            let alertController = UIAlertController(title: "Select one of the numbers", message: nil, preferredStyle: .alert)

            for i in 0...phoneNumberCount-1 {
                let phoneAction = UIAlertAction(title: contact.phoneNumbers[i].value.stringValue, style: .default, handler: {
                alert -> Void in
                    self.setNumberFromContact(contactNumber: contact.phoneNumbers[i].value.stringValue)
                })
                alertController.addAction(phoneAction)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: {
            alert -> Void in

            })
            alertController.addAction(cancelAction)

            dismiss(animated: true)
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func setNumberFromContact(contactNumber: String) {

        //UPDATE YOUR NUMBER SELECTION LOGIC AND PERFORM ACTION WITH THE SELECTED NUMBER

        var contactNumber = contactNumber.replacingOccurrences(of: "-", with: "")
        contactNumber = contactNumber.replacingOccurrences(of: "(", with: "")
        contactNumber = contactNumber.replacingOccurrences(of: ")", with: "")
        contactNumber = contactNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        guard contactNumber.count >= 10 else {
            dismiss(animated: true) {
//                self.popUpMessageError(value: 10, message: "Selected contact does not have a valid number")
            }
            return
        }
        mytextFeild.text = String(contactNumber.suffix(10))

    }

    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {

    }
    
    func Alert(title: String, message: String){
        view.shake()
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
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
       DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        strLabel.text  = "Wait for 10 Seconds"
        }
//        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 220, height: 50)
            effectView.frame = CGRect(x: mainView.frame.midX - strLabel.frame.width/2, y: mainView.frame.midY - strLabel.frame.height/2 , width: 220, height: 50)
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



extension ViewController
{
    
}
