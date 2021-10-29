//
//  FacilitiesVM.swift
//  MVVM
//
//  Created by Raji Mac Mini on 28/10/21.
//

import Foundation

enum CheckBoxImageType: String {
    case unchecked = "unchecked"
    case checked = "checked"
}

class FacilitiesVM {

    // MARK: Output Events
    var reloadTable: () -> () = { }
    
    private var listCellDatasource = [ListTableCellVM]()
    
    init() {
        getAppData()
    }
    
    private func getAppData() {
        FacilitiesWebService.getFacilities {[weak self] (facilityList, error) in
            guard let _self = self else { return }
            _self.prepareCellViewModels(facilities: facilityList)
            _self.reloadTable()
        }
    }
    
    private func prepareCellViewModels(facilities: [Facility]?) {
        
        guard let facilityList = facilities else { return }
        
        //clear all previous data
        listCellDatasource.removeAll()
        
        for facility in facilityList {
            let listCellVM = ListTableCellVM(title: facility.name, id: facility.facilityId, items: facility.facilityOptions, selectedOptionId: 0)
            listCellDatasource.append(listCellVM)
        }
        
    }
    
    //MARK: Table Methods
    func headerTitle(for index: Int) -> String {
        return listCellDatasource[index].title
    }
    
    func numberOfSections() -> Int {
        return listCellDatasource.count
    }
    
    func numberOfCells(for index: Int) -> Int {
        return listCellDatasource[index].options.count
    }
    
    func cellInfo(section: Int, for index: Int) -> OptionVM {
        return listCellDatasource[section].options[index]
    }
    
    func cellSelected(section: Int, index: Int) {
        let item = listCellDatasource[section]
        listCellDatasource[section] = ListTableCellVM(title: item.title, id: item.id, options: item.options, selectedOptionId: item.options[index].optionId)
        reloadTable()
    }
    
    func refreshTable() {
        getAppData()
    }
}
