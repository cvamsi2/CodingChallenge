//
//  BackendService.swift
//  ChannelsCodingChallenge
//
//  Created by Vamsi Chebolu on 4/8/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

/* This protocol helps to mock Networking layer for unit tetsing purpose. */
protocol BackendService {
    func request(_ request: BackendAPIRequest, completionHandler:((Data?, HTTPURLResponse?, Error?) -> Void)?)
    func requestDataWithURL(completionHandler:((Data?, HTTPURLResponse?, Error?) -> Void)?)
    func cancel()
}

extension BackendService {
    /* This method should have ability to construct URLRequest based on BackendAPIRequest variables and can be more modular. However for the sake of this challenge I am keeping this method very simply and very specific to only one GET API */
    func createNSURlRequest(_ request: BackendAPIRequest, configuration: BackendConfiguration) -> URLRequest {
        let url = configuration.baseURL.appendingPathComponent(request.endpoint)
        var channelsRequest = URLRequest(url: url)
        channelsRequest.httpMethod = request.method.rawValue
        channelsRequest.setValue(URLHeader.Value.json, forHTTPHeaderField: URLHeader.Key.contentType)
        
        return channelsRequest
    }
}
