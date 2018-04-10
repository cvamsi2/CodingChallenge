//
//  ChannelsListInteractor.swift
//  ChannelsCodingChallenge
//
//  Created by Vamsi Chebolu on 4/8/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

/* Interactors helps to keep View controllers light weight. This is place where if needed the data will be handed of to coredata layer as well. */
class ChannelsListInteractor {
    let channelService: BackendService
    
    init(backEndService: BackendService) {
        channelService = backEndService
    }
    
    func getListOfChannelsWith(request: BackendAPIRequest, completionHandler:(([Channel]?, ErrorType?) -> Void)?) {
        channelService.request(request) { (data, httpResponse, error) in
            guard error == nil, let data = data else {
                completionHandler?(nil, .internalError())
                return
            }
            if let networkResponse = try? JSONDecoder().decode(ChannelAPIResponse.self, from: data) {
                // success
                completionHandler?(networkResponse.channels, nil)
            } else if let responseString = String(data: data, encoding: .utf8), httpResponse?.statusCode != 200 {
                //Server error message
                completionHandler?(nil, .serverError(responseString))
            } else {
                completionHandler?(nil, .serverError("Something Unexpected Happened."))
            }
        }
    }
}
