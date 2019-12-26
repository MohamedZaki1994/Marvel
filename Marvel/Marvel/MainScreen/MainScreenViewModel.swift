//
//  MainScreenViewModel.swift
//  Marvel
//
//  Created by Mohamed Mahmoud Zaki on 12/26/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class MainScreenViewModel {

    func fetchData(completion: (() -> Void)?) {
        RequestHandler.request { (dataSource, error) in
            if error != nil {
                print(dataSource)
            }
        }
    }

}
