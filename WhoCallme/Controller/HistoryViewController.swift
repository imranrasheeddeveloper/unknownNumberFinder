//
//  HistoryViewController.swift
//  WhoCallme
//
//  Created by Muhammad Imran on 15/05/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import CoreData
class HistoryViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    var numbers = [String]()
    var arrayofDetail = [Detail]()
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
    var address : String?
    var address1 :  String?
    var city : String?
    var cnic : String?
    var msdate :String?
    var name : String?
    var simnumber:String?
    var region :String?
    var statusdate :String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Constants.addBannerViewToView(viewController: self)
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
             
             Constants.showInterstitial(viewController: self)
         }
    func fetchData(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                numbers.append(data.value(forKey: "number") as! String)
            }
        } catch {
            
            print("Failed")
        }
        
        DispatchQueue.main.async {
            self.myTableView.reloadData()
        }
        
        dump(numbers)
    }
    
    
    func Search(number: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        let searchString = number
        //request.predicate = NSPredicate(format: "cityName CONTAINS[cd] %@", searchString!) // contains case insensitive
        //request.predicate = NSPredicate(format: "cityName CONTAINS %@", searchString!) // contains case sensitive
        //request.predicate = NSPredicate(format: "cityName LIKE[cd] %@", searchString!) // like case insensitive
        //request.predicate = NSPredicate(format: "cityName ==[cd] %@", searchString!)  // equal case insensitive
        request.predicate = NSPredicate(format: "number == %@", searchString)  // equal case sensitive
        
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                for online in result {
                     address = (online as AnyObject).value(forKey: "address") as? String
                     address1 = (online as AnyObject).value(forKey: "address1") as? String
                     city = (online as AnyObject).value(forKey: "city") as? String
                     cnic = (online as AnyObject).value(forKey: "cnic") as? String
                     msdate = (online as AnyObject).value(forKey: "msdate") as? String
                     name = (online as AnyObject).value(forKey: "name") as? String
                     simnumber = (online as AnyObject).value(forKey: "number") as? String
                     region = (online as AnyObject).value(forKey: "region") as? String
                     statusdate = (online as AnyObject).value(forKey: "statusdate") as? String
                    
                }
            } else {
                
            }
            let obj = Detail(name: name!, cninc: cnic!, number: simnumber!, address: address!, address1: address1!, city: city!, region: region!, msDate: msdate!, statusDate: statusdate!)
            arrayofDetail.append(obj)
            dump(arrayofDetail)
        } catch {
            print(error)
        }
    }
}


extension HistoryViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = numbers[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Search(number: numbers[indexPath.row])
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        newViewController.detailArray = self.arrayofDetail
        self.navigationController?.pushViewController(newViewController, animated: true)
       
        arrayofDetail.removeAll()
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
         return "History"
     }
    
//       func tableView(_ tableView: UITableView,leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
//           let closeAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//               print("Copy")
//
//            self.deleteObject(number: self.numbers[indexPath.row])
//
//               success(true)
//           })
//           closeAction.title = "Delete"
//           closeAction.backgroundColor = .red
//        tableView.reloadData()
//           return UISwipeActionsConfiguration(actions: [closeAction])
//       }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        deleteObject(number: numbers[indexPath.row])
        tableView.reloadData()
         
    }
    
    func deleteObject(number: String){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        let searchString = number
        request.predicate = NSPredicate(format: "number == %@", searchString)  // equal
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                // Delete _all_ objects:
                for object in result {
                    context.delete(object as! NSManagedObject)
                    numbers.removeAll(where: { $0 == number })
                }
                
                // Or delete first object:
                if result.count > 0 {
                    context.delete(result[0] as! NSManagedObject)
                }
                try context.save()
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
                
            } else {
                
            }
            
        } catch {
            print(error)
        }
    }
    
    
}




