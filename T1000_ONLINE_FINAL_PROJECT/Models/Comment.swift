//
//  Comment.swift
//  T1000_ONLINE_FINAL_PROJECT
//
//  Created by يعرُب on 10/05/1443 AH.
//

import Foundation
struct Comment: Decodable {
    var id: String
    var message: String
    var owner: User
}
