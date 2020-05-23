//
//  SearchByCINCViewController.swift
//  WhoCallme
//
//  Created by Muhammad Imran on 14/05/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import WebKit
import SwiftSoup
class SearchByCINCViewController: UIViewController,WKNavigationDelegate {
    
    @IBOutlet weak var mywebview: WKWebView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var mytextField: TextFieldWithImage!
    @IBOutlet weak var searchButton: UIButton!
    var counter = 0
    var arrayofData = [String]()
    var arrayodDetail =  [Detail]()
    var number : String!
    var myactivityIndicator = UIActivityIndicatorView()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
    var indicator  = UIActivityIndicatorView()
    var strUrl:URL =  URL(string: "https://allnumber.site")!
    var strTitle = ""
    var arrayofNumbers = [String]()
    var webView: WKWebView!
    override func viewWillAppear(_ animated: Bool) {
           
           Constants.showInterstitial(viewController: self)
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        Constants.addBannerViewToView(viewController: self)
        innerView.layer.cornerRadius = 15
        searchButton.layer.cornerRadius = 12
        let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
            view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func nyButton(_ sender: Any) {
        
        if Reachability.isConnectedToNetwork(){
        if mytextField.text?.count == 13 {
            self.view.endEditing(true)
            self.webView = WKWebView()
               activityIndicator("Fetching Database")
               number = mytextField.text
               self.mywebview.isHidden = true
               self.mywebview.navigationDelegate = self
               let url = self.strUrl
               self.mywebview.load(URLRequest(url: url))
               self.mywebview.allowsBackForwardNavigationGestures = true
        }
        
        else{
            Alert(title: "Error", message: "Enter Correct CNIC 13 Digit Number ")
        }
        }
        else{
            Alert(title: "Network error", message: "Please Check Your Internet Connection")
        }
        
    }
    
    
    
    
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
                }

                for i in 0...arrayofData.count {
                    switch i {
                    case 2:
                    arrayofNumbers.append(arrayofData[i])
                    case 11:
                    arrayofNumbers.append(arrayofData[i])
                    case 20:
                    arrayofNumbers.append(arrayofData[i])
                    case 29:
                    arrayofNumbers.append(arrayofData[i])
                    case 38:
                    arrayofNumbers.append(arrayofData[i])
                    case 47:
                    arrayofNumbers.append(arrayofData[i])
                    case 56:
                    arrayofNumbers.append(arrayofData[i])
                    case 65:
                    arrayofNumbers.append(arrayofData[i])

                    default:
                        //arrayofNumbers.append("?")
                        print("Noting")
                    }
                }
                dump(arrayofNumbers)
                DispatchQueue.main.async {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "CNICNumberDetailViewController") as! CNICNumberDetailViewController
                    newViewController.arrayofNumbers = self.arrayofNumbers
                    self.navigationController?.pushViewController(newViewController, animated: true)
                    self.arrayofData.removeAll()
                    self.arrayodDetail.removeAll()
                    self.arrayofNumbers.removeAll()
                }
            }
            catch let error
            {
                print(error.localizedDescription)
                
            }
            
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

    //        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 220, height: 50)
                effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 220, height: 50)
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
