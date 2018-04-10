//
//  ChannelAPIResponse.swift
//  ChannelsCodingChallenge
//
//  Created by Vamsi Chebolu on 4/8/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

/** Model to parse Channel API response. These model creations are based on staructure of API response.*/
struct ChannelAPIResponse: Codable {
    var channels: [Channel]
}
