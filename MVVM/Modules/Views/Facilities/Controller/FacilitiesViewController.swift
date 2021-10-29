//
//  FacilitiesViewController.swift
//  MVVM
//
//  Created by Raji Mac Mini on 28/10/21.
//

import UIKit

class FacilitiesViewController: UITableViewController {

    private var viewModel = FacilitiesVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpOuputObservables()
    }
    
    func setUp() {
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    func setUpOuputObservables() {
        viewModel.reloadTable = {[weak self] in
            guard let _self = self else { return }
            DispatchQueue.main.async {
                _self.tableView?.reloadData()
            }
        }
    }
    
    private func cellForListTableAt(indexPath: IndexPath, section: Int) -> ListTableCell {
        let cell: ListTableCell = tableView?.dequeueReusableCell(withIdentifier: "facilityOptionCell", for: indexPath) as! ListTableCell
        cell.configure(info: viewModel.cellInfo(section: section, for: indexPath.row))
        return cell
    }

}

extension FacilitiesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells(for: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForListTableAt(indexPath: indexPath, section: indexPath.section)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellSelected(section: indexPath.section, index: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.headerTitle(for: section)
    }

}
