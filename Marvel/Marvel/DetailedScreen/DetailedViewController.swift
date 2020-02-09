//
//  DetailedViewController.swift
//  Marvel
//
//  Created by Mohamed Mahmoud Zaki on 12/31/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift

class DetailedViewController: UIViewController {
    var id: Int?
    var viewModel = DetailedViewModel()
    var imageView = UIImageView()
    let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = id else {return}
        tableView.register(UINib(nibName: "DetailedTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailedTableViewCell")
        tableView.register(UINib(nibName: "DetailedCollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailedCollectionTableViewCell")
        tableView.register(UINib(nibName: "RelatedLinksTableViewCell", bundle: nil), forCellReuseIdentifier: "RelatedLinksTableViewCell")

        let headerNib = UINib(nibName: "DetailedScreenHeader", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "DetailedScreenHeader")

        viewModel.fetchData(id: id)
        //
        viewModel.rxTest.subscribe(onNext: { (value) in
            print(value)
        }, onError: nil, onCompleted: nil).disposed(by: disposeBag)
        //
        viewModel.closureBinding = { [weak self] dataModel in
            print("Done Binding")
            if let path = dataModel?.thumbnail?.path,
                let ext = dataModel?.thumbnail?.thumbnailExtension.rawValue {
                self?.imageView.kf.setImage(with: URL(string: path + "." + ext))
            }
        }
    }
}

extension DetailedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0,1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedTableViewCell", for: indexPath)
            guard let detailedCell = cell as? DetailedTableViewCell else {
                return cell
            }
            return detailedCell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RelatedLinksTableViewCell", for: indexPath)
            guard let detailedCell = cell as? RelatedLinksTableViewCell else {
                return cell
            }
            return detailedCell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedCollectionTableViewCell", for: indexPath)
            guard let detailedCell = cell as? DetailedCollectionTableViewCell else {
                return cell
            }
            return detailedCell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DetailedScreenHeader") as? DetailedScreenHeader
        headerView?.imageView = imageView
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 400
    }

}
