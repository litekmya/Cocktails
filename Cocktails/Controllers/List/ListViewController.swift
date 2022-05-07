//
//  ListViewController.swift
//  Cocktails
//
//  Created by Владимир Ли on 26.04.2022.
//

import UIKit

//MARK: - Protocols
protocol ListViewInputProtocol: AnyObject {
    func setupTableView()
}

protocol ListViewOutputProtocol {
    init(view: ListViewInputProtocol)
    
    func requestData()
    func requestSections() -> [ListAllCocktailsModel]
    func getHeader(with sectionNumber: Int, delegate: ExpandableHeaderViewDelegate) -> ExpandableHeaderView
    func showCocktailDetails(at indexPath: IndexPath)
}

class ListViewController: UITableViewController, ExpandableHeaderViewDelegate {
    
    //MARK: - public properties
    var presenter: ListViewOutputProtocol!
    var configurator: ListConfiguratorProtocol = ListConfigurator()
    
    //MARK: - Private properties
    private var sections: [ListAllCocktailsModel] = ListAllCocktailsModel.getDataForSections()
    private let identifier = "cell"

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(view: self)
        presenter.requestData()
        
        sections = presenter.requestSections()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].cocktails.drinks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = sections[indexPath.section].cocktails.drinks[indexPath.row].strDrink
        
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
        let header = presenter.getHeader(with: section, delegate: self)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter.showCocktailDetails(at: indexPath)
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded.toggle()
        
        tableView.beginUpdates()
        
        for row in 0..<sections[section].cocktails.drinks.count {
            tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        
        tableView.endUpdates()
    }
}

//MARK: - InputProtocol
extension ListViewController: ListViewInputProtocol {
    
    func setupTableView() {
        title = "All cocktails"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    }
}
