//
//  BackendConfiguration.swift
//  ChannelsCodingChallenge
//
//  Created by Vamsi Chebolu on 4/8/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

struct BackendConfiguration {
    let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
}
