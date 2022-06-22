//
//  BaseDataSource.swift
//  DiffarableTest
//
//  Created by Назаров Михаил Сергеевич on 22.06.2022.
//

import Foundation
import UIKit

public protocol Model {

}

public protocol Configurable {
    func configure(with: Model)
}

open class BaseDataSource<T: Model & Hashable>: UITableViewDiffableDataSource<Int, T>, UITableViewDelegate {
    public init(tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! Configurable
            cell.configure(with: model)
            return cell as? UITableViewCell
        }
    }
}
