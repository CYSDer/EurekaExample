//
//  ListSectionsController.swift
//  Example
//
//  Created by yuanshengcao on 16/9/13.
//  Copyright © 2016年 Xmartlabs. All rights reserved.
//

import Foundation
import Eureka

class ListSectionsController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let continents = ["Africa", "Antarctica", "Asia", "Australia", "Europe", "North America", "South America"]
        
        form +++ SelectableSection<ImageCheckRow<String>, String>() { section in
            section.header = HeaderFooterView(title: "Where do you live?")
        }
        
        for option in continents {
            form.last! <<< ImageCheckRow<String>(option){ lrow in
                lrow.title = option
                lrow.selectableValue = option
                lrow.value = nil
            }
        }
        
        let oceans = ["Arctic", "Atlantic", "Indian", "Pacific", "Southern"]
        
        form +++ SelectableSection<ImageCheckRow<String>, String>("And which of the following oceans have you taken a bath in?", selectionType: .MultipleSelection)
        for option in oceans {
            form.last! <<< ImageCheckRow<String>(option){ lrow in
                lrow.title = option
                lrow.selectableValue = option
                lrow.value = nil
                }.cellSetup { cell, _ in
                    cell.trueImage = UIImage(named: "selectedRectangle")!
                    cell.falseImage = UIImage(named: "unselectedRectangle")!
            }
        }
    }
    
    override func rowValueHasBeenChanged(row: BaseRow, oldValue: Any?, newValue: Any?) {
        if row.section === form[0] {
            print("Single Selection:\((row.section as! SelectableSection<ImageCheckRow<String>, String>).selectedRow()?.baseValue)")
        }
        else if row.section === form[1] {
            print("Mutiple Selection:\((row.section as! SelectableSection<ImageCheckRow<String>, String>).selectedRows().map({$0.baseValue}))")
        }
    }
}
