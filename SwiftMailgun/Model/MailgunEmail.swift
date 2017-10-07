//
//  MailgunEmail.swift
//  SwiftMailgun
//
//  Created by Christopher Jimenez on 3/7/16.
//  Copyright © 2016 Chris Jimenez. All rights reserved.
//

import Foundation


public struct MailgunEmail: Codable {
    
    public var from: String?
    public var to: String?
    public var subject: String?
    public var html: String?
    public var text: String?
    public var attachment: Data?
    
    public init(to: String? = nil, from: String? = nil, subject: String? = nil, html: String? = nil){
        
        self.to = to
        self.from = from
        self.subject = subject
        self.html = html
        self.text = html?.htmlToString
    
    }
    
}
