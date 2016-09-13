//
//  FieldRowCustomizationController.swift
//  Example
//
//  Created by yuanshengcao on 16/9/13.
//  Copyright © 2016年 Xmartlabs. All rights reserved.
//

import Foundation
import Eureka

//MARK: Field row customization Example
class FieldRowCustomizationController : FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++
            Section(header: "Default field rows", footer: "Rows with title have a right-aligned text field.\nRows without title have a left-aligned text field.\nBut this can be changed...")
            
            <<< NameRow() {
                $0.title = "Your name:"
                $0.placeholder = "(right alignment)"
                }
                .cellSetup { cell, row in
                    cell.imageView?.image = UIImage(named: "plus_image")
            }
            
            <<< NameRow() {
                $0.placeholder = "Name (left alignment)"
                }
                .cellSetup { cell, row in
                    cell.imageView?.image = UIImage(named: "plus_image")
            }
            
            +++ Section("Customized Alignment")
            
            <<< NameRow() {
                $0.title = "Your name:"
                }.cellUpdate { cell, row in
                    cell.textField.textAlignment = .Left
                    cell.textField.placeholder = "(left alignment)"
            }
            
            <<< NameRow().cellUpdate { cell, row in
                cell.textField.textAlignment = .Right
                cell.textField.placeholder = "Name (right alignment)"
            }
            
            +++ Section(header: "Customized Text field width", footer: "Eureka allows us to set up a specific UITextField width using textFieldPercentage property. In the section above we have also right aligned the textLabels.")
            
            <<< NameRow() {
                $0.title = "Title"
                $0.textFieldPercentage = 0.6
                $0.placeholder = "textFieldPercentage = 0.6"
                }
                .cellUpdate {
                    $0.cell.textField.textAlignment = .Left
                    $0.cell.textLabel?.textAlignment = .Right
            }
            <<< NameRow() {
                $0.title = "Another Title"
                $0.textFieldPercentage = 0.6
                $0.placeholder = "textFieldPercentage = 0.6"
                }
                .cellUpdate {
                    $0.cell.textField.textAlignment = .Left
                    $0.cell.textLabel?.textAlignment = .Right
            }
            <<< NameRow() {
                $0.title = "One more"
                $0.textFieldPercentage = 0.7
                $0.placeholder = "textFieldPercentage = 0.7"
                }
                .cellUpdate {
                    $0.cell.textField.textAlignment = .Left
                    $0.cell.textLabel?.textAlignment = .Right
            }
            
            +++ Section("TextAreaRow")
            
            <<< TextAreaRow() {
                $0.placeholder = "TextAreaRow"
                $0.textAreaHeight = .Dynamic(initialTextViewHeight: 110)
        }
        
    }
}

