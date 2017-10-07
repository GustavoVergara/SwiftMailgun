//
//  CodableExtensions.swift
//  SwiftMailgun
//
//  Created by Gustavo Vergara Garcia on 06/10/17.
//  Copyright © 2017 Chris Jimenez. All rights reserved.
//

import Foundation

extension Encodable {
    
    func `as`<T>(_ type: T.Type) throws -> T where T: Decodable {
        return try JSONDecoder().decode(type, from: JSONEncoder().encode(self))
    }
    
}
