//
//  NativeEventFormViewController.swift
//  Example
//
//  Created by yuanshengcao on 16/9/13.
//  Copyright © 2016年 Xmartlabs. All rights reserved.
//

import Foundation
import Eureka

//MARK: Native Event Example

class NativeEventNavigationController: UINavigationController, RowControllerType {
    var completionCallback : ((UIViewController) -> ())?
}

class NativeEventFormViewController : FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeForm()
        
        self.navigationItem.leftBarButtonItem?.target = self
        self.navigationItem.leftBarButtonItem?.action = #selector(NativeEventFormViewController.cancelTapped(_:))
    }
    
    private func initializeForm() {
        
        form =
            
            TextRow("Title").cellSetup { cell, row in
                cell.textField.placeholder = row.tag
            }
            
            <<< TextRow("Location").cellSetup {
                $0.cell.textField.placeholder = $0.row.tag
            }
            
            +++
            
            SwitchRow("All-day") {
                $0.title = $0.tag
                }.onChange { [weak self] row in
                    let startDate: DateTimeInlineRow! = self?.form.rowByTag("Starts")
                    let endDate: DateTimeInlineRow! = self?.form.rowByTag("Ends")
                    
                    if row.value ?? false {
                        startDate.dateFormatter?.dateStyle = .MediumStyle
                        startDate.dateFormatter?.timeStyle = .NoStyle
                        endDate.dateFormatter?.dateStyle = .MediumStyle
                        endDate.dateFormatter?.timeStyle = .NoStyle
                    }
                    else {
                        startDate.dateFormatter?.dateStyle = .ShortStyle
                        startDate.dateFormatter?.timeStyle = .ShortStyle
                        endDate.dateFormatter?.dateStyle = .ShortStyle
                        endDate.dateFormatter?.timeStyle = .ShortStyle
                    }
                    startDate.updateCell()
                    endDate.updateCell()
                    startDate.inlineRow?.updateCell()
                    endDate.inlineRow?.updateCell()
            }
            
            <<< DateTimeInlineRow("Starts") {
                $0.title = $0.tag
                $0.value = NSDate().dateByAddingTimeInterval(60*60*24)
                }
                .onChange { [weak self] row in
                    let endRow: DateTimeInlineRow! = self?.form.rowByTag("Ends")
                    if row.value?.compare(endRow.value!) == .OrderedDescending {
                        endRow.value = NSDate(timeInterval: 60*60*24, sinceDate: row.value!)
                        endRow.cell!.backgroundColor = .whiteColor()
                        endRow.updateCell()
                    }
                }
                .onExpandInlineRow { cell, row, inlineRow in
                    inlineRow.cellUpdate { [weak self] cell, dateRow in
                        let allRow: SwitchRow! = self?.form.rowByTag("All-day")
                        if allRow.value ?? false {
                            cell.datePicker.datePickerMode = .Date
                        }
                        else {
                            cell.datePicker.datePickerMode = .DateAndTime
                        }
                    }
                    let color = cell.detailTextLabel?.textColor
                    row.onCollapseInlineRow { cell, _, _ in
                        cell.detailTextLabel?.textColor = color
                    }
                    cell.detailTextLabel?.textColor = cell.tintColor
            }
            
            <<< DateTimeInlineRow("Ends"){
                $0.title = $0.tag
                $0.value = NSDate().dateByAddingTimeInterval(60*60*25)
                }
                .onChange { [weak self] row in
                    let startRow: DateTimeInlineRow! = self?.form.rowByTag("Starts")
                    if row.value?.compare(startRow.value!) == .OrderedAscending {
                        row.cell!.backgroundColor = .redColor()
                    }
                    else{
                        row.cell!.backgroundColor = .whiteColor()
                    }
                    row.updateCell()
                }
                .onExpandInlineRow { cell, row, inlineRow in
                    inlineRow.cellUpdate { [weak self] cell, dateRow in
                        let allRow: SwitchRow! = self?.form.rowByTag("All-day")
                        if allRow.value ?? false {
                            cell.datePicker.datePickerMode = .Date
                        }
                        else {
                            cell.datePicker.datePickerMode = .DateAndTime
                        }
                    }
                    let color = cell.detailTextLabel?.textColor
                    row.onCollapseInlineRow { cell, _, _ in
                        cell.detailTextLabel?.textColor = color
                    }
                    cell.detailTextLabel?.textColor = cell.tintColor
        }
        
        form +++
            
            PushRow<RepeatInterval>("Repeat") {
                $0.title = $0.tag
                $0.options = RepeatInterval.allValues
                $0.value = .Never
        }
        
        form +++
            
            PushRow<EventAlert>() {
                $0.title = "Alert"
                $0.options = EventAlert.allValues
                $0.value = .Never
                }
                .onChange { [weak self] row in
                    if row.value == .Never {
                        if let second : PushRow<EventAlert> = self?.form.rowByTag("Another Alert"), let secondIndexPath = second.indexPath() {
                            row.section?.removeAtIndex(secondIndexPath.row)
                        }
                    }
                    else{
                        guard let _ : PushRow<EventAlert> = self?.form.rowByTag("Another Alert") else {
                            let second = PushRow<EventAlert>("Another Alert") {
                                $0.title = $0.tag
                                $0.value = .Never
                                $0.options = EventAlert.allValues
                            }
                            row.section?.insert(second, atIndex: row.indexPath()!.row + 1)
                            return
                        }
                    }
        }
        
        form +++
            
            PushRow<EventState>("Show As") {
                $0.title = "Show As"
                $0.options = EventState.allValues
        }
        
        form +++
            
            URLRow("URL") {
                $0.placeholder = "URL"
            }
            
            <<< TextAreaRow("notes") {
                $0.placeholder = "Notes"
                $0.textAreaHeight = .Dynamic(initialTextViewHeight: 50)
        }
        
    }
    
    func cancelTapped(barButtonItem: UIBarButtonItem) {
        (navigationController as? NativeEventNavigationController)?.completionCallback?(self)
    }
    
    enum RepeatInterval : String, CustomStringConvertible {
        case Never = "Never"
        case Every_Day = "Every Day"
        case Every_Week = "Every Week"
        case Every_2_Weeks = "Every 2 Weeks"
        case Every_Month = "Every Month"
        case Every_Year = "Every Year"
        
        var description : String { return rawValue }
        
        static let allValues = [Never, Every_Day, Every_Week, Every_2_Weeks, Every_Month, Every_Year]
    }
    
    enum EventAlert : String, CustomStringConvertible {
        case Never = "None"
        case At_time_of_event = "At time of event"
        case Five_Minutes = "5 minutes before"
        case FifTeen_Minutes = "15 minutes before"
        case Half_Hour = "30 minutes before"
        case One_Hour = "1 hour before"
        case Two_Hour = "2 hours before"
        case One_Day = "1 day before"
        case Two_Days = "2 days before"
        
        var description : String { return rawValue }
        
        static let allValues = [Never, At_time_of_event, Five_Minutes, FifTeen_Minutes, Half_Hour, One_Hour, Two_Hour, One_Day, Two_Days]
    }
    
    enum EventState {
        case Busy
        case Free
        
        static let allValues = [Busy, Free]
    }
}

