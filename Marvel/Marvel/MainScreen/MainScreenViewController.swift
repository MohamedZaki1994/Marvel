//
//  MainScreenViewController.swift
//  Marvel
//
//  Created by Mohamed Mahmoud Zaki on 12/26/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel = MainScreenViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData { [weak self] (dataModel) in
            guard let data = dataModel else { return }
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        navigationController?.navigationBar.isHidden = true
        let nib = UINib(nibName: "MainTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MainTableViewCell")
    }

}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataModel?.character?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath)
        guard let mainCell = cell as? MainTableViewCell else {return cell}
        mainCell.heroImageView.backgroundColor = .red
        mainCell.labelText.text = viewModel.dataModel?.character?[indexPath.row].name
        return mainCell
    }
}
