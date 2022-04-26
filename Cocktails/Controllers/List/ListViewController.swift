//
//  ListViewController.swift
//  Cocktails
//
//  Created by Владимир Ли on 26.04.2022.
//

import UIKit

protocol ListViewInputProtocol: AnyObject {
    
}

protocol ListViewOutputProtocol {
    init(view: ListViewInputProtocol)
    
    func requestData()
}

class ListViewController: UITableViewController {
    
    //MARK: - public properties
    var presenter: ListViewOutputProtocol!
    var configurator: ListConfiguratorProtocol = ListConfigurator()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
        presenter.requestData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
}

extension ListViewController: ListViewInputProtocol {
    
}
