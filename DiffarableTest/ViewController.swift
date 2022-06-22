//
//  ViewController.swift
//  DiffarableTest
//
//  Created by Назаров Михаил Сергеевич on 19.06.2022.
//

import UIKit
import SnapKit
import DiffableFramework

class ViewController: UITableViewController {
    lazy var dataSource = MyDataSource(tableView: tableView)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MyCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        var snapshot = NSDiffableDataSourceSnapshot<Int, MyCellModel>()
        let data = [
            "Push",
            "Kyh",
            "Cheburek",
            "afaf"
        ]
        snapshot.appendSections([0])
        snapshot.appendItems(data.map { MyCellModel(text: $0) }, toSection: 0)
        self.dataSource.apply(snapshot)
        // Do any additional setup after loading the view.
    }
    @IBAction func addButtonTapped(_ sender: Any) {
        getData()
    }

    func getData() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
            DispatchQueue.main.async {
                self.applyChanges()
            }
        }
    }

    func applyChanges() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, MyCellModel>()
        let data = [
            "Kek",
            "Hek",
            "Cheburek",
            "Loh"
        ]
        snapshot.appendSections([0])
        snapshot.appendItems(data.map { MyCellModel(text: $0) }, toSection: 0)
        self.dataSource.apply(snapshot)
    }
}

class MyCell: UITableViewCell, Configurable {
    let label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        label.text = "Hello World"
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configure(with model: Model) {
        let model = model as! MyCellModel
        label.text = model.text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct MyCellModel: Model, Hashable {
    var text: String
}


class MyDataSource: BaseDataSource<MyCellModel> {}

extension MyDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CELL SELECTED")
    }
}
