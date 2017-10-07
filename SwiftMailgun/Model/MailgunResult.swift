//
//  MailgunResult.swift
//  SwiftMailgun
//
//  Created by Christopher Jimenez on 3/7/16.
//  Copyright © 2016 Chris Jimenez. All rights reserved.
//

import Foundation

public struct MailgunResult: Codable {
    
    public var success: Bool! = false
    public var message: String?
    public var id: String?
    
    public var hasError : Bool {
        return !success
    }
    
    public init(){}
    
    
    public init(success: Bool, message: String, id: String?){
        
        self.init()
        self.success = success
        self.message = message
        self.id = id
        
    }
    
}
