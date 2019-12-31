//
//  DetailedViewModel.swift
//  Marvel
//
//  Created by Mohamed Mahmoud Zaki on 12/31/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class DetailedViewModel {

    var data: DetailedScreenDataModel?

    func fetchData(id: Int, completion: ((DetailedScreenDataModel) -> Void)?) {
        RequestHandler.request(offset: 0, path: "/" + String(id)) { [weak self] (dataSource, error) in
            if error != nil {
                return
            }
            guard let result = dataSource?.data.results.first else {return}
            self?.data = DetailedScreenDataModel(id: result.id,
                                                 name: result.name,
                                                 description: result.resultDescription,
                                                 thumbnail: result.thumbnail,
                                                 comics: result.comics,
                                                 series: result.series,
                                                 stories: result.stories,
                                                 events: result.events)

            guard let data = self?.data else {return}
            completion?(data)
        }
    }
}
