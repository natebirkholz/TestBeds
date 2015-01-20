//
//  ViewController.swift
//  WhereAmI
//
//  Created by Nathan Birkholz on 1/18/15.
//  Copyright (c) 2015 Nate Birkholz. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var stateLabel: UILabel!
  @IBOutlet weak var zipLabel: UILabel!
  @IBOutlet weak var neighborhoodLabel: UILabel!
  @IBOutlet weak var countyLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!

  let locationManager = CLLocationManager()
  var city : String?
  var state : String?
  var zipCode: String?
  var time : String?


  override func viewDidLoad() {
    super.viewDidLoad()

    switch CLLocationManager.authorizationStatus() as CLAuthorizationStatus {
    case .Authorized:
      println("Authorized status for CLLocationManager.")
    case .AuthorizedWhenInUse:
      println("AuthorizedWhenInUse status for CLLocationManager.")
    case .Denied:
      println("Denied status for CLLocationManager.")
    case .NotDetermined:
      println("NotDetermined status for CLLocationManager. Requesting authorization.")
      self.locationManager.requestWhenInUseAuthorization()
    case .Restricted:
      println("Restricted status for CLLocationManager.")
    default:
      println("authorization status not found for CLLocationManager.")
    }


  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    switch status {
    case .Authorized:
      println("Case authorized for didChangeAuthorizationStatus")
    case .AuthorizedWhenInUse:
      println("Case AuthorizedWhenInUse for didChangeAuthorizationStatus")
    case .Denied:
      println("Case Denied for didChangeAuthorizationStatus")
    case .NotDetermined:
      println("Case NotDetermined for didChangeAuthorizationStatus")
    case .Restricted:
      println("Case Restricted for didChangeAuthorizationStatus")
    default:
      println("Dfeault case for didChangeAuthorizationStatus")
    }
  }

  @IBAction func findMyLocation(sender: AnyObject) {
    println("THIS")
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.startUpdatingLocation()


  }

  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
      if (error != nil) {
        println("Reverse geocoder failed with error: \(error.localizedDescription)")

        return
      }
      println(placemarks.count)
      if placemarks.count > 0 {
        let pm = placemarks[0] as CLPlacemark
        self.displayLocationInfo(pm)
        self.locationManager.stopUpdatingLocation()
      } else {
        println("Problem with data from geocoder")
        self.locationManager.stopUpdatingLocation()

      }
    })
  }

  func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
    println("Error while updating location: \(error.localizedDescription)")
    self.locationManager.stopUpdatingLocation()

  }

  func displayLocationInfo(placemark: CLPlacemark) {
    if placemark.locality != nil {
      locationManager.stopUpdatingLocation()
      println("locality is: " + placemark.locality ?? "no location")
      println("postalCode is: " + placemark.postalCode ?? "no postal code")
      println("administrativeArea is: " + placemark.administrativeArea ?? "no administrative area")
      println("country is: " + placemark.country ?? "no country")
      println("location is: \(placemark.location)" ?? "no location")

      self.cityLabel.text = placemark.locality as String!
      self.stateLabel.text = placemark.administrativeArea as String!
      self.zipLabel.text = placemark.postalCode as String!
      self.neighborhoodLabel.text = placemark.subLocality as String!
      self.countyLabel.text = placemark.subAdministrativeArea as String!
      self.addressLabel.text = placemark.subThoroughfare + " " + placemark.thoroughfare as String!

    } else {
      println("nil locality")
    }
  }

}

