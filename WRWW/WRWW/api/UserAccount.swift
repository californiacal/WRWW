//
//  UserAccount.swift
//  WRWW
//
//  Created by John Swensen on 6/21/16.
//  Copyright © 2016 WRWW. All rights reserved.
//

import Foundation
import LoopBack


class UserRepository : LBUserRepository {
    override init!(className name: String!) {
        super.init(className: "Users")
    }
    override init() {
        super.init(className: "Users")
    }
    
}


class User : LBUser {
    
}