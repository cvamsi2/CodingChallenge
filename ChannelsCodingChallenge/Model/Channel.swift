//
//  Channel.swift
//  ChannelsCodingChallenge
//
//  Created by Vamsi Chebolu on 4/8/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//
import Foundation

/* Model to parse Channels from channel API request. Only attributes needed for this app were included in this model. If required the model can always be enhanced to include other attributes */
struct Channel: Codable {
    /* I don't have info what are the required attributes. Usually this input comes from functional team mentioning the required attributes and api team needs to adhere to that.  Hence most of them are non-optional */
    var id: String
    var title: String
    var description: String
    var dj: String
    var djmail: String
    var genre: String
    var thumbnailImageURL: String
    /* In json response from API "largeimage" attribute is missing for Channel "live" and hence only making this optional and rest non optional. Not sure if this bad data or it was done purposefully */
    var largeImageURL: String?
    var extraLargeImageURL: String
    var listeners: String?
    
    /* Need enum coding keys to customize attribute names */
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case dj
        case djmail
        case genre
        case thumbnailImageURL = "image"
        case largeImageURL = "largeimage"
        case extraLargeImageURL = "xlimage"
        case listeners
    }
}
