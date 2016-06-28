//
//  WRWWApi.swift
//  WRWW
//
//  Created by John Swensen on 6/24/16.
//  Copyright © 2016 WRWW. All rights reserved.
//

import Foundation
import LoopBack

class WardrobeUser : LBPersistedModel {
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

class WardrobeUserRepository : LBPersistedModelRepository     {
    override init() {
        super.init(className: "wardrobe_users")
    }
    class func repository() -> WardrobeUserRepository {
        return WardrobeUserRepository()
    }
}


// API object for the user_closet table
class UserCloset : LBPersistedModel {
    var id: NSNumber!
    var owner_id: NSNumber!
    var closet_name: String!
    var wardrobe_type_id: NSNumber!
    var privacy_level_id: NSNumber!
    var user_location_id: NSNumber!
    var create_date: NSDate!
    var delete_datetime: NSDate!
    
    var user_closet_items: [UserClosetItem]? = nil
}

class UserClosetRepository : LBPersistedModelRepository     {
    override init() {
        super.init(className: "user_closets")
    }
    class func repository() -> UserClosetRepository {
        return UserClosetRepository()
    }
}


// API object for the user_closet_item
class UserClosetItem : LBPersistedModel {
    var id: NSNumber!
    var user_closet_id: NSNumber!
    var item_name: String!
    var item_img_url: String!
    var create_date: NSDate!
    var delete_datetime: NSDate!

}

class UserClosetItemRepository : LBPersistedModelRepository     {
    override init() {
        super.init(className: "user_closet_items")
    }
    class func repository() -> UserClosetItemRepository {
        return UserClosetItemRepository()
    }
}



// API object for the user_outfit_category
class UserOutfitCategory : LBPersistedModel {
    var id: NSNumber!
    var outfit_name: String!
    var owner_id: NSNumber!
    var create_date: NSDate!
    var delete_datetime: NSDate!
    
    var user_outfits: [UserOutfit]? = nil
}

class UserOutfitCategoryRepository : LBPersistedModelRepository     {
    override init() {
        super.init(className: "user_outfit_categories")
    }
    class func repository() -> UserOutfitCategoryRepository {
        return UserOutfitCategoryRepository()
    }
}



// API object for the user_outfit
class UserOutfit : LBPersistedModel {
    var id: NSNumber!
    var outfit_name: String!
    var user_closet_id: NSNumber!
    var outfit_img_url: String!
    var create_date: NSDate!
    var delete_datetime: NSDate!
    
    var user_outfit_items: [UserOutfitItem]? = nil
}

class UserOutfitRepository : LBPersistedModelRepository     {
    override init() {
        super.init(className: "user_outfits")
    }
    class func repository() -> UserOutfitRepository {
        return UserOutfitRepository()
    }
}



// API object for the user_outfit_item
class UserOutfitItem : LBPersistedModel {
    var id: NSNumber!
    var user_outfit_id: NSNumber!
    var user_closet_item_id: NSNumber!
    
    var user_closet_items: [UserClosetItem]? = nil
}

class UserOutfitItemRepository : LBPersistedModelRepository     {
    override init() {
        super.init(className: "user_outfit_items")
    }
    class func repository() -> UserOutfitItemRepository {
        return UserOutfitItemRepository()
    }
}




