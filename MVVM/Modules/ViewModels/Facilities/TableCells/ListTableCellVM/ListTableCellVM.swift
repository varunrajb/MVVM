//
//  ListTableCellVM.swift
//  MVVM
//
//  Created by Raji Mac Mini on 28/10/21.
//

import UIKit

struct ListTableCellVM {
    let title: String
    let id: Int
    let selectedOptionId: Int
    
    var options = [OptionVM]()
    
    init(title: String, id: Int, items: [FacilityOption], selectedOptionId: Int) {
        self.title = title
        self.id = id
        self.selectedOptionId = selectedOptionId
        prepare(items: items)
    }
    
    init(title: String, id: Int, options: [OptionVM], selectedOptionId: Int) {
        self.title = title
        self.id = id
        self.selectedOptionId = selectedOptionId
        prepareOther(options: options)
    }
     

    mutating func prepare(items: [FacilityOption]) {
        for item in items {
            let optionModel =  OptionVM(optionsImage:item.iconName , optionsTitle: item.name, optionsStatusImage: CheckBoxImageType.unchecked.rawValue, optionId: item.optionId)
            options.append(optionModel)
        }
    }
    
    mutating func prepareOther(options: [OptionVM]) {
        for option in options {
            var selectedImage = CheckBoxImageType.unchecked.rawValue
            if (option.optionId == self.selectedOptionId) {
                selectedImage = CheckBoxImageType.checked.rawValue
            }
            let optionModel = OptionVM(optionsImage:option.optionsImage , optionsTitle: option.optionsTitle, optionsStatusImage: selectedImage, optionId: option.optionId)
            self.options.append(optionModel)
        }
    }
    
}


