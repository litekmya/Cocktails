//
//  ExpandableHeaderView.swift
//  Cocktails
//
//  Created by Владимир Ли on 26.04.2022.
//

import UIKit

protocol ExpandableHeaderViewDelegate {
    func toggleSection(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {

    private var delegate: ExpandableHeaderViewDelegate?
    private var sectionNumber: Int?
    
    private var expanded: Bool?
    private var title: String!
    private let chevronForwardImage = UIImage(systemName: "chevron.forward")
    private let chevronDownImage = UIImage(systemName: "chevron.down")
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHeaderView(with title: String, sectionNumber: Int, expanded: Bool, delegate: ExpandableHeaderViewDelegate) {
        self.delegate = delegate
        self.sectionNumber = sectionNumber
        self.expanded = expanded
        
        let content = self.setup(cell: self, title: title, image: chevronForwardImage!)
        self.title = title
                
        self.contentConfiguration = content
    }
    
    @objc private func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        
        var content = cell.defaultContentConfiguration()

        cell.expanded?.toggle()

        if cell.expanded ?? false {
            content = setup(cell: cell, title: title, image: chevronDownImage!)
        } else {
            content = setup(cell: cell, title: title, image: chevronForwardImage!)
        }

        cell.contentConfiguration = content
        
        delegate?.toggleSection(header: self, section: cell.sectionNumber ?? 0)
    }
    
    private func setup(cell: ExpandableHeaderView, title: String, image: UIImage) -> UIListContentConfiguration {
        var content = cell.defaultContentConfiguration()
        content.text = title
        content.image = image
        content.textProperties.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        
        return content
    }
}
