//
//  MainScreenViewController.swift
//  Marvel
//
//  Created by Mohamed Mahmoud Zaki on 12/26/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit
import Kingfisher
import UserNotifications

class MainScreenViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel = MainScreenViewModel()
    var isLoading = false
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData()
        viewModel.loadedData = { [weak self] dataModel in
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
                self?.tableView.reloadData()
                self?.hideActivityIndicator()
            }
        }
        navigationController?.navigationBar.isHidden = true
        let nib = UINib(nibName: "MainTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MainTableViewCell")
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) {
            (granted, error) in
            if granted {
                print("yes")
            } else {
                print("No")
            }
        }

            let content = UNMutableNotificationContent()
            content.title = "Notification Tutorial"
            content.subtitle = "from ioscreator.com"
            content.body = " Notification triggered"
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)

            // 4
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    func showActivityIndicator() {
        let minX = view.frame.midX - (40/2)
        actInd.frame = CGRect(x: minX, y: view.frame.height - 40.0, width: 40.0, height: 40.0);
        actInd.hidesWhenStopped = true
        actInd.style = .large
        view.addSubview(actInd)
        actInd.startAnimating()
    }

    func hideActivityIndicator() {
        actInd.stopAnimating()
        actInd.removeFromSuperview()
    }
}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataModel.character?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath)
        guard let mainCell = cell as? MainTableViewCell else {return cell}
        mainCell.labelText.text = viewModel.dataModel.character?[indexPath.row].name

        if let path = viewModel.dataModel.character?[indexPath.row].thumbnail?.path,
            let thumnbailExtension = viewModel.dataModel.character?[indexPath.row].thumbnail?.thumbnailExtension {

            let urlPath = path + "." + thumnbailExtension.rawValue
            let url = URL(string: urlPath)
            mainCell.config(url: url)
        }
        return mainCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailedViewController") as? DetailedViewController
        detailedVC?.id = viewModel.dataModel.character?[indexPath.row].id
        guard let detailedViewcontroller = detailedVC else { return }
        navigationController?.pushViewController(detailedViewcontroller, animated: true)
    }
}

extension MainScreenViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y + tableView.frame.height >= tableView.contentSize.height {
            if viewModel.dataModel.character?.count == 50 {
                return
            }
            if !isLoading {
                showActivityIndicator()
                viewModel.fetchData()
                isLoading = true
            }
        }
    }
}
