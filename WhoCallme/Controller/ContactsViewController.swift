//
//  ContactsViewController.swift
//  WhoCallme
//
//  Created by Muhammad Imran on 12/05/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import Contacts



struct Contacts {
    var name : String
    var number : String
}

class ContactsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate {
    @IBOutlet weak var myTableview: UITableView!

    var resultSearch = UISearchController()
    var contactsArray = [Contacts]()
    var fillterResult = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = contactsArray[indexPath.row].name
        cell.detailTextLabel?.text = contactsArray[indexPath.row].number
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All Contacts"
    }
    func updateSearchResults(for searchController: UISearchController) {
       
        guard let searchText = searchController.searchBar.text else{return}
        if searchText == ""{
            
            fetchContacts { contacts in
                    for c in contacts {
                        let obj =    Contacts(name: c.givenName, number: c.phoneNumbers.first?.value.stringValue ?? " ")
                        self.contactsArray.append(obj)
                    }
                DispatchQueue.main.async {
                    self.myTableview.reloadData()
                }
                }
            
        }
        else{
            fetchContacts { contacts in
                    for c in contacts {
                        let obj =    Contacts(name: c.givenName, number: c.phoneNumbers.first?.value.stringValue ?? " ")
                        self.contactsArray.append(obj)
                    }
                }
            contactsArray = contactsArray.filter{
                $0.name.contains(searchText)
            }
            myTableview.reloadData()
        }
     }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        var numberof = contactsArray[indexPath.row].number
        numberof.remove(at: numberof.startIndex)
        newViewController.number = numberof
        navigationController?.pushViewController(newViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        resultSearch = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.hidesNavigationBarDuringPresentation = false
            //controller.dimsBackgroundDuringPresentation = false
            navigationItem.hidesSearchBarWhenScrolling = true
            navigationItem.searchController = controller
            
            return controller
        })()
        
        fetchContacts { contacts in
                for c in contacts {
                    let obj =    Contacts(name: c.givenName, number: c.phoneNumbers.first?.value.stringValue ?? " ")
                    self.contactsArray.append(obj)
                }
            DispatchQueue.main.async {
                self.myTableview.reloadData()
            }
            }
    
        }

    }
    

    
    func fetchContacts(completion: @escaping (_ result: [CNContact]) -> Void){
        DispatchQueue.main.async {
            var results = [CNContact]()
            let keys = [CNContactGivenNameKey,CNContactFamilyNameKey,CNContactMiddleNameKey,CNContactEmailAddressesKey,CNContactPhoneNumbersKey] as [CNKeyDescriptor]
            let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
            fetchRequest.sortOrder = .userDefault
            let store = CNContactStore()
            store.requestAccess(for: .contacts, completionHandler: {(grant,error) in
                if grant{
                    do {
                        try store.enumerateContacts(with: fetchRequest, usingBlock: { (contact, stop) -> Void in
                            results.append(contact)
                        })
                    }
                    catch let error {
                        print(error.localizedDescription)
                    }
                    completion(results)
                }else{
                    print("Error \(error?.localizedDescription ?? "")")
                }
            })
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
