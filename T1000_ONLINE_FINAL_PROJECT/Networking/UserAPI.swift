//
//  UserAPI.swift
//  T1000_ONLINE_FINAL_PROJECT
//
//  Created by يعرُب on 15/05/1443 AH.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserAPI: API {
    static func getUserData(id: String, completionHandler: @escaping (User) -> ()){
        
        let url = "\(baseURL)/user/\(id)"
        
        AF.request(url, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: jsonData.rawData())
                completionHandler(user)
                
            }catch let error{
                print(error)
            }
            
        }
    }
    
    
    static func registerNewUser( firstName: String, lastName: String, email: String, completionHandler: @escaping (User?, String? ) -> ()){
        
        let url = "\(baseURL)/user/create"
        let params = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email
        ]
        
        AF.request(url, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result{
            case .success:
                let jsonData = JSON(response.value)
                print(jsonData)
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: jsonData.rawData())
                    completionHandler(user, nil)
                    
                }catch let error{
                    print(error)
                }
            case .failure(let error):
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                
                // error messages
                let emailError = data["email"].stringValue
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                let errorMessage = emailError + " " + firstNameError + " " + lastNameError
                
                
                
                completionHandler(nil, errorMessage)
            }
            
            
            
        }
    }
    
    
    static func signInUser( firstName: String, lastName: String, completionHandler: @escaping (User?, String? ) -> ()){
        
        let url = "\(baseURL)/user"
        let params = [
            "created" : "1"
        ]
        
        AF.request(url, method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result{
            case .success:
                let jsonData = JSON(response.value)
                let data = jsonData["data"]
                print(jsonData)
                let decoder = JSONDecoder()
                do {
                    let users = try decoder.decode([User].self, from: data.rawData())
                    
                    
                
                    var foundUser: User?
                    for user in users {
                        if user.firstName == firstName && user.lastName == lastName {
                            foundUser = user
                            break
                        }
                    }
                    
                    if let user = foundUser {
                        completionHandler(user, nil)
                    }else {
                        completionHandler(nil, "The firstname or the lastname don't match any user")
                    }
//                    completionHandler(user, nil)
                    
                }catch let error{
                    print(error)
                }
            case .failure(let error):
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                
                // error messages
                let emailError = data["email"].stringValue
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                let errorMessage = emailError + " " + firstNameError + " " + lastNameError
                
                
                
                completionHandler(nil, errorMessage)
            }
            
            
            
        }
    }
    
    
    static func updateUserInfo(userId: String, firstName: String, phone: String, imageUrl: String, completionHandler: @escaping (User?, String? ) -> ()){
        
        let url = "\(baseURL)/user/\(userId)"
        let params = [
            "firstName" : firstName,
            "phone": phone,
            "picture": imageUrl
        ]
        
        AF.request(url, method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result{
            case .success:
                let jsonData = JSON(response.value)
                
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: jsonData.rawData())
                    
                    completionHandler(user, nil)
                    
                }catch let error{
                    print(error)
                }
            case .failure(let error):
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                
                // error messages
                let emailError = data["email"].stringValue
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                let errorMessage = emailError + " " + firstNameError + " " + lastNameError
                
                
                
                completionHandler(nil, errorMessage)
            }
            
            
            
        }
    }
}
