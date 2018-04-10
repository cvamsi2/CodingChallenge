//
//  ChannelsNetworking.swift
//  ChannelsCodingChallenge
//
//  Created by Vamsi Chebolu on 4/8/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

/* Keeping only 2 error types one for server and one for client side */
enum ErrorType {
    case serverError(String?)
    case internalError()
    
    func getAlertMessage() -> String {
        switch self {
        case .serverError(let message):
            return message ?? ""
        case .internalError():
            return "Something UnExpected Happened."
        }
    }
}

/** Constants struct for networking */
struct ChannelsNetworking {
    /* We don't have environments in this example, but this is where those constants would live. */
    private struct Domain {
        private static let dev = "raw.githubusercontent.com"
        private static let qa = "raw.githubusercontent.com"
        private static let uat = "raw.githubusercontent.com"
        private static let prod = "raw.githubusercontent.com"
        
        /* Hardcoding this for now, but this value would be accessed from the scheme the app is built with. */
        static func currentEnvironment() -> String {
            return dev
        }
    }
    
    /* Everything for this API does not have a route like "/api" or "/v2/api". In a production app, this is where environment specific or different routes for the API would live. */
    private struct Route {
        static let api = "" // example could be "/api"
    }
    
    private static let baseURL = Domain.currentEnvironment()

    static func channelsAPIURL() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        
        guard let url = urlComponents.url else {
            /* Should crash if this can't construct so it is clear where this happens since the app relies on this to function. */
            fatalError("Could not construct URL for passes endpoint.")
        }
        
        return url
    }
}
