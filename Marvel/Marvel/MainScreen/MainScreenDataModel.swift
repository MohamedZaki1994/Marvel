//
//  MainScreenDataModel.swift
//  Marvel
//
//  Created by Mohamed Mahmoud Zaki on 12/29/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

struct MainScreenDataModel {
    var character: [Character]?
}

struct Character {
    var id: Int?
    var name: String?
    var modified: String?
    var thumbnail: Thumbnail?
}
