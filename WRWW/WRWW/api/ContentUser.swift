//
//  ContentUser.swift
//  WRWW
//
//  Created by John Swensen on 6/20/16.
//  Copyright © 2016 WRWW. All rights reserved.
//

import Foundation
import LoopBack

class ContentUser : LBPersistedModel {
    var id: NSNumber!
    var owner_id: NSNumber!
    var first_name: String!
    var last_name: String!
    var link: String!
    var gender: String!
    var locale: String!
    var age_range: String!
    var phone_number: String!
    var access_token: String!
    var email: String!
    var last_modified: NSDate!
}