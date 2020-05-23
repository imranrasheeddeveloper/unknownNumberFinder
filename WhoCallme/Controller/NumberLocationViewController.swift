//
//  NumberLocationViewController.swift
//  WhoCallme
//
//  Created by Muhammad Imran on 16/05/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import MapKit
class NumberLocationViewController: UIViewController {

    
    @IBOutlet weak var MapSegment: UISegmentedControl!
    var maptitle : String?
    var mapSubtitle : String?
    var lat : Double?
    var lang : Double?
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.title =  "Location"
        LoadMap()
        MapSegment.setTitle("Standard", forSegmentAt: 0)
        MapSegment.setTitle("satellite", forSegmentAt: 1)

        }
    override func viewWillAppear(_ animated: Bool) {
             Constants.addBannerViewToView(viewController: self)
             Constants.showInterstitial(viewController: self)
         }
        
    @IBAction func MapViewIndexChanged(_ sender: Any) {
        
        switch MapSegment.selectedSegmentIndex
           {
           case 0:
            mapView.mapType = MKMapType.standard
            LoadMap()
           case 1:
            
            mapView.mapType = MKMapType.hybrid
            LoadMap()
           default:
               break
           }
    }
    func LoadMap(){
        
        if let lat = lat {
            if let lang = lang{
                let location = CLLocationCoordinate2D(latitude: lat,
                      longitude: lang)
                  
                  // 2
                  let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                  let region = MKCoordinateRegion(center: location, span: span)
                      mapView.setRegion(region, animated: true)
                      
                  //3
                  let annotation = MKPointAnnotation()
                  annotation.coordinate = location
                  annotation.title = maptitle
                  annotation.subtitle = mapSubtitle
                  mapView.addAnnotation(annotation)
            }

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

}
