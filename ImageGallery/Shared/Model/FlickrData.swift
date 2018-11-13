//
//  FlickrData.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 11/11/18.
//  Copyright © 2018 Akash Rastogi. All rights reserved.
//

import Foundation

struct FlickrData: Decodable {
    
    let title: String?
    let link: URL?
    var arrImages: [FlickrImage]
    
    private enum CodingKeys: String, CodingKey {
        case title
        case link
        case arrImages = "items"
    }
    
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try values.decode(String.self, forKey: .title)
        link = try values.decode(URL.self, forKey: .link)
        
        let array = try values.decode([FlickrImage].self, forKey: .arrImages)
        arrImages = array
    }
}

struct FlickrImage: Decodable {
    
    let title: String?
    let imageDescription: String?
    let authorId: String?
    let imageLink: URL?
    let createdAt: Date?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case imageDescription = "description"
        case authorId = "author_id"
        case media
        case dateTaken = "date_taken"
    }
    
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        title = try values.decode(String.self, forKey: .title)
        imageDescription = try values.decode(String.self, forKey: .imageDescription)
        authorId = try values.decode(String.self, forKey: .authorId)
        
        //get image link
        let dict = try values.decode(Dictionary<String, String>.self, forKey: .media)
        imageLink = URL.init(string: dict["m"] ?? "")
        
        //date parsing
        let strDate = try values.decode(String.self, forKey: .dateTaken)
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        createdAt = dateFormatter.date(from: strDate)
    }
    
}

