//
//  Copy.swift
//  Cocktails
//
//  Created by Владимир Ли on 05.05.2022.
//

import Foundation

//enum URLs: String {
//    case randomTenCocktails = "https://www.thecocktaildb.com/api/json/v2/9973533/randomselection.php"
//    case firstAddress = "https://www.thecocktaildb.com/api/json/v2/9973533/recent.php"
//    case allCocktails = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f="
//}

//struct ListAllCocktailsModel {
//    var sectionName: String
//    var cocktails: Cocktails
//    var expanded: Bool
//
//    static var sections: [ListAllCocktailsModel] = []
//}
//
//extension ListAllCocktailsModel {
//
//    static func getDataForSections() -> [ListAllCocktailsModel] {
//        let alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j",
//                        "k", "l", "m", "n", "o", "p", "q", "r", "s", "t",
//                        "u", "v","w", "x", "y", "z"]
//
//        DispatchQueue.main.async {
//
//            for index in 0..<alphabet.count {
//                NetworkManager.shared.fetchData(from: URLs.allCocktails.rawValue + alphabet[index]) { cocktails in
//                    let section = ListAllCocktailsModel(sectionName: alphabet[index], cocktails: cocktails, expanded: false)
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                        sections.append(section)
//                        print(sections.count)
//                    }
//                }
//            }
//        }
//
//        return sections
//    }
//}


//protocol ListViewInputProtocol: AnyObject {
//    func setupTableView()
//}
//
//protocol ListViewOutputProtocol {
//    init(view: ListViewInputProtocol)
//
//    func requestData()
//}
//
//class ListViewController: UITableViewController, ExpandableHeaderViewDelegate {
//
//    //MARK: - public properties
//    var presenter: ListViewOutputProtocol!
//    var configurator: ListConfiguratorProtocol = ListConfigurator()
//
//    //MARK: - Private properties
//    private var sections: [ListAllCocktailsModel] = ListAllCocktailsModel.getDataForSections()
//    private let identifier = "cell"
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configurator.configure(view: self)
//        presenter.requestData()
//
//        sections = ListAllCocktailsModel.sections
//
//        title = "All cocktails"
//    }
//
//    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        sections.count
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        sections[section].cocktails.drinks.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
//
//        var content = cell.defaultContentConfiguration()
//        content.text = sections[indexPath.section].cocktails.drinks[indexPath.row].strDrink
//
//        cell.contentConfiguration = content
//
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        44
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if sections[indexPath.section].expanded {
//            return 44
//        }
//
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        44
//    }
//
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let header = ExpandableHeaderView()
//        header.setupHeaderView(with: sections[section].sectionName, sectionNumber: section, expanded: sections[section].expanded, delegate: self)
//
//        return header
//    }
//
//    func toggleSection(header: ExpandableHeaderView, section: Int) {
//        sections[section].expanded.toggle()
//
//        tableView.beginUpdates()
//
//        for row in 0..<sections[section].cocktails.drinks.count {
//            tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
//        }
//
//        tableView.endUpdates()
//    }
//}
//
////MARK: - InputProtocol
//extension ListViewController: ListViewInputProtocol {
//
//    func setupTableView() {
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
//    }
//}

