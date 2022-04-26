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

    var delegate: ExpandableHeaderViewDelegate?
    var sectionNumber: Int?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHeaderView(with title: String, sectionNumber: Int, delegate: ExpandableHeaderViewDelegate) {
        self.delegate = delegate
        self.sectionNumber = sectionNumber
        self.backgroundColor = .gray
        
        var content = self.defaultContentConfiguration()
        content.text = title
        content.textProperties.color = .white
        
        self.contentConfiguration = content
    }
    
    @objc private func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        delegate?.toggleSection(header: self, section: cell.sectionNumber ?? 0)
    }
}
