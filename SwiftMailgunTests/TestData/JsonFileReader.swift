//
//  JsonFileReader.swift
//  SwiftMailgun
//
//  Created by Chris Jimenez on 3/7/16.
//  Copyright © 2016 Chris Jimenez. All rights reserved.
//

import Foundation

/// Reads a file from path and retunrs the object representation
open class JSONFileReader {
    
    /**
     Reads a json from a file
     
     - parameter file: local file
     
     - returns: Object dic
     */
    static func data(fromFileNamed file: String) -> Data? {
        guard let path = Bundle(for: self).path(forResource: file, ofType: "json") else {
            return nil
        }
        
        return try? Data(contentsOf: URL(fileURLWithPath: path))        
    }
    
}
