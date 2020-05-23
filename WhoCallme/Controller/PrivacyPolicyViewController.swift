//
//  PrivacyPolicyViewController.swift
//  WhoCallme
//
//  Created by Muhammad Imran on 16/05/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {

    @IBOutlet weak var effectview: UIVisualEffectView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var textView: UITextView!
    
    let text = """
➽The information provided by this app is 100% correct for Pakistan.
➽This information is for educational purposes only and any illegal use of this information will lead to a legal consequences.
➽Use this application on your behalf developer or company is not responsible for any illegal use of information.
➽This Application do not tend to store or expose any sensitive information of user
"""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationItem.title = "Policy"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = text
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.showsVerticalScrollIndicator = true
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.scrollRangeToVisible(NSMakeRange(0, 0))
        textView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
