//
//  ListViewController.swift
//  Cocktails
//
//  Created by Владимир Ли on 26.04.2022.
//

import UIKit

protocol ListViewInputProtocol: AnyObject {
    func setupTableView()
}

protocol ListViewOutputProtocol {
    init(view: ListViewInputProtocol)
    
    func requestData()
}

class ListViewController: UITableViewController, ExpandableHeaderViewDelegate {
    
    //MARK: - public properties
    var presenter: ListViewOutputProtocol!
    var configurator: ListConfiguratorProtocol = ListConfigurator()
    
    //MARK: - Private properties
    private var sections: [ListAllCocktailsModel] = ListAllCocktailsModel.getNameForSections()
    private let identifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
        presenter.requestData()
        
        title = "All cocktials"
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].cocktails.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = sections[indexPath.section].cocktails[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].expanded {
            return 44
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.setupHeaderView(with: sections[section].sectionName, sectionNumber: section, expanded: sections[section].expanded, delegate: self)
        
        return header
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded.toggle()
        
        tableView.beginUpdates()
        
        for row in 0..<sections[section].cocktails.count {
            tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        
        tableView.endUpdates()
    }
}

//MARK: - InputProtocol
extension ListViewController: ListViewInputProtocol {
    
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    }
}
