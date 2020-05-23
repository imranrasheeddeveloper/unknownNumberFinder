//
//  Networking.swift
//  WhoCallme
//
//  Created by Muhammad Imran on 15/05/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation


class Networking{
    
    func APICall(phoneNumber : String ,completionalHandler: @escaping(PhoneNumber) -> Void)  {
        let headers = [
            "x-rapidapi-host": "f-sm-jorquera-phone-insights-v1.p.rapidapi.com",
            "x-rapidapi-key": "629e407f20mshb17a2e1a78b657dp17e929jsn126e2adc8dc8",
            "content-type": "application/json",
            "accept": "application/json"
        ]
        let parameters = ["phone_number": phoneNumber] as [String : Any]
        do { let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            let request = NSMutableURLRequest(url: NSURL(string: "https://f-sm-jorquera-phone-insights-v1.p.rapidapi.com/parse")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: .infinity)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error as Any)
                } else {
                    let decode = JSONDecoder()
                    do{
                        let jsondata = try decode.decode(PhoneNumber.self, from: data!)
                     
                        completionalHandler(jsondata)
                    }catch let error{
                        
                        print(error.localizedDescription)
                    }
                }
            })
            
            
            dataTask.resume()
        }
        catch{
            
        }
    }
    
    
    func CountryCallingCode(countryName: String, completionalHandler: @escaping([String:String]) -> Void){
        
        let headers = [
            "x-rapidapi-host": "metropolis-api-phone.p.rapidapi.com",
            "x-rapidapi-key": "629e407f20mshb17a2e1a78b657dp17e929jsn126e2adc8dc8"
        ]
        
        let urlString = "https://metropolis-api-phone.p.rapidapi.com/iso?country=\(countryName)"
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        var request = URLRequest(url: url!)

//        let request = NSMutableURLRequest(url: NSURL(string: "https://metropolis-api-phone.p.rapidapi.com/iso?country=Pakistan")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:String]
                        print(json)
                        completionalHandler(json)
                    } catch {
                        print(error)
                    }
                }

            }
        })

        dataTask.resume()
    }
    
    
    
    func NumberDetail(phoneNumber: String, completionalHandler: @escaping([String:Any]) -> Void){
        
        var dict = [String:Any]()
        let headers = [
            "x-rapidapi-host": "f-sm-jorquera-phone-insights-v1.p.rapidapi.com",
            "x-rapidapi-key": "629e407f20mshb17a2e1a78b657dp17e929jsn126e2adc8dc8",
            "content-type": "application/json",
            "accept": "application/json"
        ]
        let parameters = ["phone_number": phoneNumber] as [String : Any]
        do { let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            let request = NSMutableURLRequest(url: NSURL(string: "https://f-sm-jorquera-phone-insights-v1.p.rapidapi.com/parse")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: .infinity)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error as Any)
                } else {
                   if let data = data {
                                      do {
                                          dict = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                                          print(dict)
                                          completionalHandler(dict)
                                      } catch {
                                          print(error)
                                      }
                                  }
                }
            })
            
                
            dataTask.resume()
        }
        catch{
            
        }
    }
    
    func countrycallingCode(countryName: String ,completionalHandler: @escaping(CallingCodes) -> Void){
        let headers = [
            "x-rapidapi-host": "metropolis-api-phone.p.rapidapi.com",
            "x-rapidapi-key": "629e407f20mshb17a2e1a78b657dp17e929jsn126e2adc8dc8"
        ]
        print(countryName)
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://metropolis-api-phone.p.rapidapi.com/iso?country=Pakistan")! as URL, cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                let decode = JSONDecoder()
                do{
                    let jsondata = try decode.decode(CallingCodes.self, from: data!)
                    print(jsondata)
                    completionalHandler(jsondata)
                }catch let error{
                    print(error.localizedDescription)
                }
            }
        })

        dataTask.resume()
    }
    
    
    
    
    
    
}
