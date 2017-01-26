//
//  HistoryViewController.swift
//  ios-travis
//
//  Created by KAGE on 1/27/17.
//  Copyright © 2017 KAGE. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet fileprivate weak var historyTableView: UITableView! {
        didSet {
            self.historyTableView.dataSource = self
        }
    }

    fileprivate var histories: [History] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configure(histories: [History]) {
        self.histories = histories.reversed()
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.histories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        if let c = cell as? HistoryTableViewCell {
            c.configure(self.histories[indexPath.row])
        }

        return cell
    }
}
