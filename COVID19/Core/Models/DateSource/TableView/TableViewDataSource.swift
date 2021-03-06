//
//  TableViewDataSource.swift
//  COVID19
//
//  Created by Mohamed Shemy on Thu 12 Aug 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

typealias ConfigurableTableViewCell = UITableViewCell & Configurable

typealias ReportValuesTableViewDataSource = TableViewDataSource<ReportValue, ReportTableViewCell>

class TableViewDataSource<Model, Cell: ConfigurableTableViewCell>: NSObject, UITableViewDataSource, UITableViewDelegate
where Cell.Model == Model
{
    // MARK:- Properties
    
    private(set) var items: [Model]
    weak var delegate: DataSourceDelegate?
    
    var animationType: UIView.AnimationType = .none
    var cellHeight: CGFloat = 48
    var isEmpty: Bool { items.isEmpty }
    
    // MARK:- init
    
    init(_ items: [Model])
    {
        self.items = items
    }
    
    // MARK:- Methods
    
    func item(at indexPath: IndexPath) -> Model
    {
        return items[indexPath.row]
    }
    
    func selectItem(at indexPath: IndexPath)
    {
        guard indexPath.row.inRange(of: items) else { return }
        
        let item = item(at: indexPath)
        delegate?.didSelect(item, at: indexPath)
    }
    
    // MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let item = item(at: indexPath)
        let cell: Cell = tableView.dequeue()
        cell.configure(item, at: indexPath)
        return cell
    }
    
    // MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        cellHeight == -1 ? UITableView.automaticDimension : cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        cell.animate(animationType)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        let item = item(at: indexPath)
        delegate?.didDeselect(item, at: indexPath)
    }
}
