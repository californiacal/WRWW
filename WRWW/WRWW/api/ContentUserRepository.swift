//
//  ContentUserRepository.swift
//  WRWW
//
//  Created by John Swensen on 6/20/16.
//  Copyright © 2016 WRWW. All rights reserved.
//

import Foundation
import LoopBack

class ContentUserRepository : LBPersistedModelRepository     {
    override init() {
        super.init(className: "content_users")
    }
    class func repository() -> ContentUserRepository {
        return ContentUserRepository()
    }
    
}
