//
//  InternationalHistoryViewController.swift
//  WhoCallme
//
//  Created by Muhammad Imran on 16/05/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import CoreData
class InternationalHistoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = numbers[indexPath.row]
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        SearchNumber(number: numbers[indexPath.row])
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "InternationDetailViewController") as! InternationDetailViewController
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
    override func viewWillAppear(_ animated: Bool) {
             
             Constants.showInterstitial(viewController: self)
         }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 70
     }
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return "History"
     }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        deleteObject(number: numbers[indexPath.row])
        tableView.reloadData()
         
    }
    
    func deleteObject(number: String){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "InternationalHistory")
        let searchString = number
        request.predicate = NSPredicate(format: "phone_number_e164 == %@", searchString)  // equal
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
    
     var arrayofDetail = [internationalPhoneNumberDetail]()
     var location : String?
     var national_number : Int?
     var carrier : String?
     var is_valid_number : Bool?
     var location_latitude : Double?
     var country_code_iso : String?
     var country_code: Int?
     var phone_number_e164  :String?
     var number_type : String?
     var location_longitude : Double?
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "InternationalHistory")
    override func viewDidLoad() {
        super.viewDidLoad()
      Constants.addBannerViewToView(viewController: self)
        fetchData()
        dump(numbers)

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var myTableView: UITableView!
    
    
    var numbers = [String]()
    func fetchData(){
          
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                numbers.append(data.value(forKey: "phone_number_e164") as! String)
            }
        } catch {
            
            print("Failed")
        }
        
        DispatchQueue.main.async {
                 self.myTableView.reloadData()
             }

        
        dump(numbers)
    }
    
    func SearchNumber(number: String)
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let searchString = number
            request.predicate = NSPredicate(format: "phone_number_e164 == %@", searchString)  // equal case sensitive
            
            do {
                let result = try context.fetch(request)
                if result.count > 0 {
                    for online in result {
                         location = (online as AnyObject).value(forKey: "location") as? String
                         national_number = (online as AnyObject).value(forKey: "national_number") as? Int
                         carrier = (online as AnyObject).value(forKey: "carrier") as? String
                         is_valid_number = (online as AnyObject).value(forKey: "is_valid_number") as? Bool
                         location_latitude = (online as AnyObject).value(forKey: "location_latitude") as? Double
                         country_code_iso = (online as AnyObject).value(forKey: "country_code_iso") as? String
                         country_code = (online as AnyObject).value(forKey: "country_code") as? Int
                         phone_number_e164 = (online as AnyObject).value(forKey: "phone_number_e164") as? String
                         number_type = (online as AnyObject).value(forKey: "number_type") as? String
                         location_longitude = (online as AnyObject).value(forKey: "location_longitude") as? Double
                        
                    }
                } else {
                    
                }
                let obj = internationalPhoneNumberDetail(location: location!, national_number: national_number!, carrier: carrier!, is_valid_number: is_valid_number!, location_latitude: location_latitude!, country_code_iso: country_code_iso!, country_code: country_code!, phone_number_e164: phone_number_e164!, number_type: number_type!, location_longitude: location_longitude!)
                self.arrayofDetail.append(obj)
            } catch {
                print(error)
            }
        }

}
