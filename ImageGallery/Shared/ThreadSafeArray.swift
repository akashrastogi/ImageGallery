//
//  ThreadSafeArray.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 11/11/18.
//  Copyright © 2018 Akash Rastogi. All rights reserved.
//

import Foundation

class ThreadSafeArray<T> {
    
    private let concurrentPhotoQueue = DispatchQueue(
        label: "com.akash.ImageGallery.photoQueue",
        attributes: .concurrent)
    private var array = [T]()
    
    var values: [T] {
        var photosCopy: [T]!
        concurrentPhotoQueue.sync {
            photosCopy = self.array
        }
        return photosCopy
    }
    
    func add(_ element: T) {
        concurrentPhotoQueue.async(flags: .barrier) { [weak self] in
            self?.array.append(element)
        }
    }
    
    func remove(at index: Int) -> T? {
        
        var element: T?
        
        concurrentPhotoQueue.sync(flags: .barrier) {
            
            if array.startIndex ..< array.endIndex ~= index {
                element = array.remove(at: index)
            }
        }
        
        return element
    }
    
}

extension ThreadSafeArray where T: Comparable {
    func remove(element: T) -> T? {
        
        var deletedValue: T?
        
        concurrentPhotoQueue.sync(flags: .barrier) {
            
            if let index = array.index(where: { (item) -> Bool in
                item == element
            }) {
                deletedValue = array.remove(at: index)
            }
        }
        return deletedValue
    }
    
    func contains(_ element:T)-> Bool {
        return array.contains(where: { (item) -> Bool in
            item == element
        })
    }
}
