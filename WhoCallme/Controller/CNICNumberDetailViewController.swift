//
//  CNICNumberDetailViewController.swift
//  WhoCallme
//
//  Created by Muhammad Imran on 15/05/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class CNICNumberDetailViewController: UIViewController {

    
    var arrayofNumbers =  [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
Constants.addBannerViewToView(viewController: self)
        // Do any additional setup after loading the view.
    }
    

}


extension CNICNumberDetailViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayofNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell", for: indexPath)
        cell.textLabel?.text = arrayofNumbers[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

            let blurEffect = UIBlurEffect(style: .light)
               let blurEffectView = UIVisualEffectView(effect: blurEffect)

               // Gets the header view as a UITableViewHeaderFooterView and changes the text colour and adds above blur effect
               let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            headerView.textLabel!.textColor = UIColor.darkGray
               headerView.textLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 13)
            headerView.tintColor = .groupTableViewBackground
               headerView.backgroundView = blurEffectView

        // For Header Text Color
        let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = .white
            
        }
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 20
            
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 70
     }
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return "All Registerd  Numbers"
     }
    
       func tableView(_ tableView: UITableView,leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
           let closeAction = UIContextualAction(style: .normal, title:  "Close", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
               print("Copy")

                   let cell = tableView.cellForRow(at: indexPath)
                   UIPasteboard.general.string = cell?.textLabel?.text

               success(true)
           })
           closeAction.title = "Copy"
           closeAction.backgroundColor = .purple

           return UISwipeActionsConfiguration(actions: [closeAction])
       }
    override func viewWillAppear(_ animated: Bool) {
             
             Constants.showInterstitial(viewController: self)
         }
    
}
