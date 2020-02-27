//
//  RelatedLinksTableViewCell.swift
//  Marvel
//
//  Created by Mohamed Mahmoud Zaki on 1/12/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit

class RelatedLinksTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dataSource = self
        tableView.dataSource = self
        let nib = UINib(nibName: "RelatedLinkItemTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RelatedLinkItemTableViewCell")
        tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey] {
                let size = newvalue as? CGSize
                let cellHeight = size?.height
                tableviewHeight.constant = cellHeight ?? 0
            }
        }
        tableView.removeObserver(self, forKeyPath: "contentSize")
    }

}

extension RelatedLinksTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RelatedLinkItemTableViewCell", for: indexPath)
        guard let relatedCell = cell as? RelatedLinkItemTableViewCell else {
            return cell
        }
        return relatedCell
    }
}
