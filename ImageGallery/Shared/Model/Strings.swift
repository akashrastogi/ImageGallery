//
//  Strings.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 11/11/18.
//

import Foundation

/// _Strings_ is a struct responsible to hold all the strings in this application
struct Strings {
    
    struct NavigationTitle {
        static let publicFeed = NSLocalizedString("Image Gallery", comment: "Flickr public photos")
    }
    
    struct Error {
        
        static let genericTitle = NSLocalizedString("Sorry", comment: "Generic error title")
        static let genericMessage = NSLocalizedString("Something went wrong.", comment: "Generic error message")
        static let okButtonTitle = NSLocalizedString("Ok", comment: "Alert button title")
    }
}
