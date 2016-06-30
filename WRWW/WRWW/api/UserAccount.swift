//
//  UserAccount.swift
//  WRWW
//
//  Created by John Swensen on 6/21/16.
//  Copyright © 2016 WRWW. All rights reserved.
//

import Foundation
import LoopBack
import Locksmith

struct ApiAccount: ReadableSecureStorable,
    CreateableSecureStorable,
    DeleteableSecureStorable,
    GenericPasswordSecureStorable
{
    let username: String
    let password: String
    
    let service = "WRWW"
    var account: String { return username }
    var data: [String: AnyObject] {
        return ["password": password]
    }
}

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



class Container : LBFile {
    
}

class ContainerRepository : LBFileRepository
{
    override init!(className name: String!) {
        super.init(className: "containers")
    }
    override init() {
        super.init(className: "containers")
    }
}