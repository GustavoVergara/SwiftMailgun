//
//  MailgunAPI.swift
//  SwiftMailgun
//
//  Created by Christopher Jimenez on 3/7/16.
//  Copyright © 2016 Chris Jimenez. All rights reserved.
//

//
//  MandrillAPI.swift
//  SwiftMandrill
//
//  Created by Christopher Jimenez on 1/18/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Alamofire

/// Mailgun API Class to be use to send emails
open class MailgunAPI {
    
    private let apiKey: String
    private let domain: String
    
    /**
     Inits the API with the ApiKey and client domain
     
     - parameter apiKey:       Api key to use the API
     - parameter clientDomain: Client domain authorized to send your emails
     
     - returns: MailGun API Object
     */
    public init(apiKey: String, clientDomain: String) {
        self.apiKey = apiKey
        self.domain = clientDomain
    }
    
    
    /**
     Sends an email with the provided parameters
     
     - parameter to:                email to
     - parameter from:              email from
     - parameter subject:           subject of the email
     - parameter bodyHTML:          html body of the email, can be also plain text
     - parameter completionHandler: the completion handler
     */
    open func sendEmail(to: String, from: String, subject: String, bodyHTML: String, completionHandler:@escaping (MailgunResult)-> Void) -> Void {
        let email = MailgunEmail(to: to, from: from, subject: subject, html: bodyHTML)
        
        self.sendEmail(email, completionHandler: completionHandler)
    }
    
    /**
     Send the email with the email object
     
     - parameter email:             email object
     - parameter completionHandler: completion handler
     */
    open func sendEmail(_ email: MailgunEmail, completionHandler: @escaping (MailgunResult) -> Void) -> Void {
        
        /// Serialize the object to an dictionary of [String:Anyobject]
        guard let params = try? email.as([String : String].self) else {
            completionHandler(MailgunResult(success: false, message: "Fail to parse MailgunEmail", id: nil))
            return
        }
        
        //The mailgun API expect multipart params. 
        //Setups the multipart request
        Alamofire.upload(
            multipartFormData: { multipartFormData in
            
                // add parameters as multipart form data to the body
                for (key, value) in params {
                    multipartFormData.append(value.data(using: .utf8, allowLossyConversion: false)!, withName: key)
                }
        
            },
            to: ApiRouter.sendEmail(self.domain).urlStringWithApiKey(self.apiKey),
            encodingCompletion: { encodingResult in
                switch encodingResult {
                //Check if it works
                case .success(let upload, _, _):
                    upload.responseData { response in
                        do {
                            var result = try JSONDecoder().decode(MailgunResult.self, from: response.result.unwrap())
                            
                            result.success = true
                            
                            completionHandler(result)

                        } catch {
                            print("error calling \(ApiRouter.sendEmail)")
                            
                            let errorMessage = error.localizedDescription
                            
                            if let data = response.data {
                                let errorData = String(data: data, encoding: String.Encoding.utf8)
                                print(errorData as Any)
                            }
                            
                            let result = MailgunResult(success: false, message: errorMessage, id: nil)
                            
                            completionHandler(result)
                        }
                    }
                //Check if we fail
                case .failure(let error):
                    print("error calling \(ApiRouter.sendEmail)")
                    print(error)
                    
                    completionHandler(MailgunResult(success: false, message: "There was an error", id: nil))
                    return
                }
            }
        )
        
    }
    
    //ApiRouter enum that will take care of the routing of the urls and paths of the API
    private enum ApiRouter {
        case sendEmail(String)
        
        var path: String {
            switch self{
            case .sendEmail(let domain):
                return "\(domain)/messages";
                
            }
        }
        
        func urlStringWithApiKey(_ apiKey : String) -> URLConvertible {
            //Builds the url with the API key
            return "https://api:\(apiKey)@\(Constants.mailgunApiURL)/\(self.path)"
        }
        
    }
    
}

