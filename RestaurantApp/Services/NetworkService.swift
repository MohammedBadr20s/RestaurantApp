//
//  NetworkService.swift
//  RestaurantApp
//
//  Created by Mohammed Badr on 2019-03-12.
//  Copyright © 2019 Mohammed Badr. All rights reserved.
//

import Foundation
import Moya

private let apiKey = "rJQczzCzdHLMFSF4ZQOdQU_aZDiy1_JOgtrMMe6HX8da9YXmjiDqKRi1vQiKCgD1rxR9omGQBlDXuTt55Mw7Zjro6RDyQnTQ9fKr8NtQ8moIHIAWA29VsuDrXRGIXHYx"

enum YelpService {
    enum bussinessProvider: TargetType {
        
        var baseURL: URL {
            return URL (string: "https://api.yelp.com/v3/businesses")!
        }
        
        var path: String {
            switch self {
            case .search:
                return "/search"
            }
        }
        
        var method: Moya.Method {
            return .get
        }
        
        var sampleData: Data {
            return Data()
        }
        
        var task: Task {
            switch self {
            case let .search(lat,long):
                return .requestParameters(parameters: ["latitude": lat, "longitude": long, "limit": 10], encoding: URLEncoding.queryString)
            }
        }
        
        var headers: [String : String]? {
            return ["Authorization": "Bearer \(apiKey)"]
        }
        
        case search (lat: Double, long: Double)
    }
}
