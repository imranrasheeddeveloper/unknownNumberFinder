//
//  InternationDetailViewController.swift
//  WhoCallme
//
//  Created by Muhammad Imran on 16/05/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import CoreData
class InternationDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Constants.addBannerViewToView(viewController: self)
        if detailArray.count != 0{
            if SearchNumber(number: detailArray[0].phone_number_e164) != 0{
                         print("number Already Exist")
                         }
                         else{
                         save()
                         }
              }
              else{return}
        
         //create a new button
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom) 
                //set image for button
        button.setImage(UIImage(named: "location.png"), for: UIControl.State.normal)
                //add function for button
        button.addTarget(self, action: #selector(addTapped), for: UIControl.Event.touchUpInside)
                //set frame
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 31)

                let barButton = UIBarButtonItem(customView: button)
                //assign button to navigationbar
                self.navigationItem.rightBarButtonItem = barButton
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Location on Map", style: .plain, target: self, action: #selector(addTapped))
        
        // Do any additional setup after loading the view.
    }
    
    var history = [NSManagedObject]()
    func save() {
          
          guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
          }
          
          // 1
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
          // 2
          let entity =
            NSEntityDescription.entity(forEntityName: "InternationalHistory",
                                       in: managedContext)!
          
          let numberhistory = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
          
          // 3

        numberhistory.setValue(detailArray[0].location, forKeyPath: "location")
        numberhistory.setValue(detailArray[0].national_number, forKeyPath: "national_number")
        numberhistory.setValue(detailArray[0].carrier, forKeyPath: "carrier")
        numberhistory.setValue(detailArray[0].is_valid_number, forKeyPath: "is_valid_number")
        numberhistory.setValue(detailArray[0].location_latitude, forKeyPath: "location_latitude")
        numberhistory.setValue(detailArray[0].country_code_iso, forKeyPath: "country_code_iso")
        numberhistory.setValue(detailArray[0].country_code, forKeyPath: "country_code")
        numberhistory.setValue(detailArray[0].phone_number_e164, forKeyPath: "phone_number_e164")
        numberhistory.setValue(detailArray[0].number_type, forKeyPath: "number_type")
        numberhistory.setValue(detailArray[0].location_longitude, forKeyPath: "location_longitude")
            
            
          
          // 4
          do {
            try managedContext.save()
            history.append(numberhistory)
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
        }
        
    @IBOutlet weak var myRableview: UITableView!
    var detailArray = [internationalPhoneNumberDetail]()
    let Sections =  ["location","national_number","carrier","is_valid_number","country_code_iso","country_code","phone_number_e164","number_type","location_longitude","location_latitude"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell", for: indexPath)
        
        
        cell.textLabel?.numberOfLines = 0
             switch (indexPath.section) {
                case 0:
                    cell.textLabel?.text = detailArray[indexPath.row].location
                case 1:
                    cell.textLabel?.text = String(detailArray[indexPath.row].national_number)
                 case 2:
                    cell.textLabel?.text = detailArray[indexPath.row].carrier
                 case 3:
                    cell.textLabel?.text = String(detailArray[indexPath.row].is_valid_number)
                 case 4:
                    cell.textLabel?.text = detailArray[indexPath.row].country_code_iso
                 case 5:
                    cell.textLabel?.text = String(detailArray[indexPath.row].country_code)
                 case 6:
                    cell.textLabel?.text = detailArray[indexPath.row].phone_number_e164
                 case 7:
                    cell.textLabel?.text = detailArray[indexPath.row].number_type
                 case 8:
                    cell.textLabel?.text = String(detailArray[indexPath.row].location_longitude)
                case 9:
                    cell.textLabel?.text = String(detailArray[indexPath.row].location_latitude)
                default:
                  cell.textLabel?.text = "Data Not Found Retry"
             }
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 70
        }
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return self.Sections[section]
        }
        func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

         //For Header Background Color
    //     view.tintColor = .black
            
            // This is the blur effect

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
            return .leastNormalMagnitude
            
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Constants.addBannerViewToView(viewController: self)
                    Constants.showInterstitial(viewController: self)
        super.viewWillAppear(true)
         self.navigationItem.title = "History"
    }
    

    
    @objc func addTapped(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "NumberLocationViewController") as! NumberLocationViewController
        newViewController.maptitle = detailArray[0].phone_number_e164
        newViewController.mapSubtitle = detailArray[0].location
        newViewController.lat = detailArray[0].location_latitude
        newViewController.lang = detailArray[0].location_longitude
        navigationController?.navigationItem.title = "Location"
        navigationController?.pushViewController(newViewController, animated: true)
    }

    func SearchNumber(number: String) -> Int
    {   print(number)
        var count = 0
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "InternationalHistory")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let searchString = number
        request.predicate = NSPredicate(format: "phone_number_e164 == %@", searchString)  // equal case sensitive
        
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                for online in result {
                 let phone_number_e164 = (online as AnyObject).value(forKey: "phone_number_e164") as? String
                   // print(phone_number_e164)
    
                }
                count = result.count
                print(count)
            } else {
                
            }
      
        } catch {
            print(error)
        }
        return count
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
