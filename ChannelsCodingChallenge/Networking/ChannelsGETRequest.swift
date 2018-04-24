//
//  ChannelsGETRequest.swift
//  ChannelsCodingChallenge
//
//  Created by Vamsi Chebolu on 4/8/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

struct ChannelsGETRequest: BackendAPIRequest {
    // Conforming to protocol
    var urlParameter: Parameters?
    
    var body: [String : Any]?
    
    var rawBody: Data?
    
    var endpoint: String {
        return "/channels.json"
    }
    
    var method: Method {
        return .get
    }
}
