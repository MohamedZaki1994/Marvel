//
//  DetailedViewModel.swift
//  Marvel
//
//  Created by Mohamed Mahmoud Zaki on 12/31/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DetailedViewModel {

    var closureBinding: ((DetailedScreenDataModel?) -> Void)?
    var data: DetailedScreenDataModel? {
        didSet {
            closureBinding?(self.data)
        }
    }
    var vari = BehaviorRelay(value: DetailedScreenDataModel())
    var rxTest: Observable<DetailedScreenDataModel> {
        return vari.asObservable()
    }

    func fetchData(id: Int) {
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

            self?.testRX()
        }
    }

    func testRX() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.vari.accept(self.data!)
        }
    }
}
