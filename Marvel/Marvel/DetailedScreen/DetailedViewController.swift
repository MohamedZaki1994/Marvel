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
    let offset: CGFloat = 400
    @IBOutlet weak var backkButton: UIButton!
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

        tableView.contentInset = UIEdgeInsets(top: offset - 44, left: 0, bottom: 0, right: 0)
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: offset)
        view.bringSubviewToFront(backkButton)
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
            DispatchQueue.main.async {
                self?.tableView.reloadData()
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
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedTableViewCell", for: indexPath)
            guard let detailedCell = cell as? DetailedTableViewCell else {
                return cell
            }
            detailedCell.title.text = "NAME"
            detailedCell.descriptionLabel.text = viewModel.data?.name
            return detailedCell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedTableViewCell", for: indexPath)
            guard let detailedCell = cell as? DetailedTableViewCell else {
                return cell
            }
            detailedCell.title.text = "DESCRIPTION"
            detailedCell.descriptionLabel.text = viewModel.data?.description?.isEmpty ?? true ? "No description": viewModel.data?.description
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

}

extension DetailedViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = -(scrollView.contentOffset.y)
        if scrollView.contentOffset.y < -offset + 44 {
            imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: offsetY + 44)
        } else if scrollView.contentOffset.y < 0 {
            imageView.frame = CGRect(x: 0, y: offsetY - offset + 44, width: UIScreen.main.bounds.size.width, height: offset)
        } else {
            imageView.frame = CGRect(x: 0, y: -offset, width: UIScreen.main.bounds.size.width, height: offset)
        }
    }
}
