//
//  MainScreenViewModel.swift
//  Marvel
//
//  Created by Mohamed Mahmoud Zaki on 12/26/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import SDWebImage

class MainScreenViewModel {

    var dataModel:  MainScreenDataModel?
    func fetchData(completion: ((MainScreenDataModel?) -> Void)?) {
        RequestHandler.request { [weak self] (dataSource, error) in
            guard let self = self else {return}
            if error == nil {
                var characters = [Character]()
                dataSource?.data.results.forEach({ (result) in
                    characters.append(Character(id: result.id,
                                                name: result.name,
                                                modified: result.modified,
                                                thumbnail: result.thumbnail))
                })
                self.dataModel = MainScreenDataModel(character: characters)
                completion?(self.dataModel)
            }
        }
    }
}
