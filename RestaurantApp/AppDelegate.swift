//
//  AppDelegate.swift
//  RestaurantApp
//
//  Created by Mohammed Badr on 2019-03-10.
//  Copyright © 2019 Mohammed Badr. All rights reserved.
//

import UIKit
import Moya
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow()
    let locationService = LocationService()
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let service = MoyaProvider<YelpService.bussinessProvider>()
    let jsonDecoder = JSONDecoder()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        locationService.didChangeStatus = { [weak self] success in
            if success {
                self?.locationService.getLocation()
            }
        }
        
        locationService.newLocation = { [weak self] result in
            switch result {
            case .success(let location):
                self?.loadBusinesses(with: location.coordinate)
            case .failure(let error):
                assertionFailure("Error getting the users location \(error)")
            }
        }
        
        switch locationService.status {
        case .notDetermined, .denied, .restricted:
            let locationViewController = storyBoard.instantiateViewController(withIdentifier: "locationViewController") as? LocationViewController
            locationViewController?.delegate = self
            window.rootViewController = locationViewController
        default:
            let nav = storyBoard
                .instantiateViewController(withIdentifier: "RestaurantNavigationController") as? UINavigationController
            window.rootViewController = nav
            locationService.getLocation()
            (nav?.topViewController as? RestaurantTableViewController)?.delegate = self
        }
        window.makeKeyAndVisible()
        return true
    }
    private func loadDetails (withId id: String) {
        service.request(.details(id: id)) { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let strongSelf = self else {return}
                let details = try? strongSelf.jsonDecoder.decode(Details.self, from: response.data)
                print("Details: \n\n \(details)")
            case .failure(let error):
                print("Failed to get Details \(error)")
            }
        }
    }
    
    
    private func loadBusinesses(with coordinate: CLLocationCoordinate2D) {
        service.request(.search(lat: coordinate.latitude, long: coordinate.longitude)) {[weak self] (result) in
            switch result {
            case .success(let response):
                guard let strongSelf = self else {return}
                let root = try? strongSelf.jsonDecoder.decode(Root.self, from: response.data)
                let viewModels = root?.businesses.compactMap(restaurantListViewModel.init)
                .sorted(by: {$0.distance < $1.distance})
                if let nav = strongSelf.window.rootViewController as? UINavigationController,
                    let restaurantListViewController = nav.topViewController as? RestaurantTableViewController {
                    restaurantListViewController.viewModels = viewModels ?? []
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}


extension AppDelegate: LocationActions, ListActions {
    func didTapAllow() {
        locationService.requestLocationAuthorization()
    }
    
    func didTapCall(_ viewModel: restaurantListViewModel) {
        loadDetails(withId: viewModel.id)
    }
}
