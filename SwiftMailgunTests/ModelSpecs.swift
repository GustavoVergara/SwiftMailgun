//
//  ModelSpecs.swift
//  SwiftMailgun
//
//  Created by Chris Jimenez on 3/7/16.
//  Copyright © 2016 Chris Jimenez. All rights reserved.
//

import Foundation

import Nimble
import Quick
@testable import SwiftMailgun


/// Model specs using fake data.
class TestDataModelSpecs: QuickSpec{
    override func spec() {
        
        let toEmail = "cjimenez16@gmail.com"
        
        it("Decode email result"){
            
            let json = JSONFileReader.data(fromFileNamed: "mailgun_result")!
            
            let emailResult: MailgunResult? = try? JSONDecoder().decode(MailgunResult.self, from: json)
                
                //ObjectParser.objectFromJson(JSONFileReader.JSON(fromFile: "mailgun_result"))
            
            expect(emailResult).toNot(beNil())
            expect(emailResult?.message).toNot(beNil())
            expect(emailResult?.id).toNot(beNil())
            
        }
        
        
        it("Decode email"){
            
            let json = JSONFileReader.data(fromFileNamed: "mailgun_email")!
            
            let emailObject: MailgunEmail? = try? JSONDecoder().decode(MailgunEmail.self, from: json)
            
            expect(emailObject).toNot(beNil())
            expect(emailObject?.from).toNot(beNil())
            expect(emailObject?.to).toNot(beNil())
            expect(emailObject?.to).to(equal(toEmail))
            
            
        }
        
    }
}
