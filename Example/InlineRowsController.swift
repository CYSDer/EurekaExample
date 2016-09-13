//
//  InlineRowsController.swift
//  Example
//
//  Created by yuanshengcao on 16/9/13.
//  Copyright © 2016年 Xmartlabs. All rights reserved.
//

import Foundation
import Eureka

class InlineRowsController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form.inlineRowHideOptions = InlineRowHideOptions.AnotherInlineRowIsShown.union(.FirstResponderChanges)
        
        form
            
            +++ Section("Automatically Hide Inline Rows?")
            
            <<< SwitchRow() {
                $0.title = "Hides when another inline row is shown"
                $0.value = true
                }
                .onChange { [weak form] in
                    if $0.value == true {
                        form?.inlineRowHideOptions = form?.inlineRowHideOptions?.union(.AnotherInlineRowIsShown)
                    }
                    else {
                        form?.inlineRowHideOptions = form?.inlineRowHideOptions?.subtract(.AnotherInlineRowIsShown)
                    }
            }
            
            <<< SwitchRow() {
                $0.title = "Hides when the First Responder changes"
                $0.value = true
                }
                .onChange { [weak form] in
                    if $0.value == true {
                        form?.inlineRowHideOptions = form?.inlineRowHideOptions?.union(.FirstResponderChanges)
                    }
                    else {
                        form?.inlineRowHideOptions = form?.inlineRowHideOptions?.subtract(.FirstResponderChanges)
                    }
            }
            
            +++ Section()
            
            <<< DateInlineRow() {
                $0.title = "DateInlineRow"
                $0.value = NSDate()
            }
            
            <<< TimeInlineRow(){
                $0.title = "TimeInlineRow"
                $0.value = NSDate()
            }
            
            <<< DateTimeInlineRow(){
                $0.title = "DateTimeInlineRow"
                $0.value = NSDate()
            }
            
            <<< CountDownInlineRow(){
                $0.title = "CountDownInlineRow"
                let dateComp = NSDateComponents()
                dateComp.hour = 18
                dateComp.minute = 33
                dateComp.timeZone = NSTimeZone.systemTimeZone()
                $0.value = NSCalendar.currentCalendar().dateFromComponents(dateComp)
            }
            
            +++ Section("Generic inline picker")
            
            <<< PickerInlineRow<NSDate>("PickerInlineRow") { (row : PickerInlineRow<NSDate>) -> Void in
                row.title = row.tag
                row.displayValueFor = { (rowValue: NSDate?) in
                    return rowValue.map { "Year \(NSCalendar.currentCalendar().component(.Year, fromDate: $0))" }
                }
                row.options = []
                var date = NSDate()
                for _ in 1...10{
                    row.options.append(date)
                    date = date.dateByAddingTimeInterval(60*60*24*365)
                }
                row.value = row.options[0]
        }
    }
}
