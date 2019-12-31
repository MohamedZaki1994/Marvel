//
//  DetailedViewController.swift
//  Marvel
//
//  Created by Mohamed Mahmoud Zaki on 12/31/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit
import Kingfisher

class DetailedViewController: UIViewController {
    var id: Int?
    var viewModel = DetailedViewModel()

    @IBOutlet weak var imageView: UIImageView!
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = id else {return}
        viewModel.fetchData(id: id) { [weak self] (dataModel) in

            if let path = dataModel.thumbnail?.path,
                let ext = dataModel.thumbnail?.thumbnailExtension.rawValue {
                self?.imageView.kf.setImage(with: URL(string: path + "." + ext))
            }

            print("Done")
        }
    }
}
