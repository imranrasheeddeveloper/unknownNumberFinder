//
//  HowToUseViewController.swift
//  WhoCallme
//
//  Created by Muhammad Imran on 17/05/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class HowToUseViewController: UIViewController {

    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var blurview: UIVisualEffectView!
       let text = """
    ➽In This Application You can Serach the Pakistan Local Mobile Phone Number Information and International Mobile Number Information
    ➽Application Search The Number Information By Three Procedures
    ➽Search By Number Pakistan Section Where You Enter Any Mobile Number Without Country code and Withoud First "0" so You Can Get Mobile Number Information Only till 2017 Sims Information Available we Are Working on Latest Data
    ➽In Search By CNIC Number Section Enter CNIC Number of Pakistan Nationality Holder You Can Get All Numbers Which Are Registered On Your CNIC number
    ➽In International Number Detail Section You can Get International Number Information First Enter the country code with + Sign Then Enter Number YOu can Get Approximately Pin Location of Mobile Number
    ➽Yor all Search history will be Save on your Locall Device So You can Get Offline Mobile Number Information
    ➽This information is for educational purposes only and any illegal use of this information will lead to a legal consequences
    """
    override func viewDidLoad() {
        super.viewDidLoad()
        textview.text = text
        self.navigationItem.title = "How to Use?"
        textview.showsVerticalScrollIndicator = true
        textview.isEditable = false
        textview.isScrollEnabled = true
        textview.scrollRangeToVisible(NSMakeRange(0, 0))
        textview.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
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
