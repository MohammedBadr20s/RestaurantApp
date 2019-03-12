//
//  AppDelegate.swift
//  RestaurantApp
//
//  Created by Mohammed Badr on 2019-03-10.
//  Copyright © 2019 Mohammed Badr. All rights reserved.
//

import UIKit
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow()
    let locationService = LocationService()
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let service = MoyaProvider<YelpService.bussinessProvider>()
    let jsonDecoder = JSONDecoder()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        switch locationService.status {
        case .notDetermined, .denied, .restricted:
            let locationViewController = storyBoard.instantiateViewController(withIdentifier: "locationViewController") as? LocationViewController
            locationViewController?.locationService = locationService
            window.rootViewController = locationViewController
        default:
            let nav = storyBoard
                .instantiateViewController(withIdentifier: "RestaurantNavigationController") as? UINavigationController
            window.rootViewController = nav
            loadBusinesses()
        }
        window.makeKeyAndVisible()
        return true
    }
    private func loadBusinesses() {
        service.request(.search(lat: 42.361145, long: -71.075083)) { (result) in
            switch result {
            case .success(let response):
                let root = try? self.jsonDecoder.decode(Root.self, from: response.data)
                let viewModels = root?.businesses.compactMap(restaurantListViewModel.init)
                if let nav = self.window.rootViewController as? UINavigationController,
                    let restaurantListViewController = nav.topViewController as? RestaurantTableViewController {
                    restaurantListViewController.viewModels = viewModels ?? []
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

