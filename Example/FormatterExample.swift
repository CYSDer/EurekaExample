//
//  FormatterExample.swift
//  Example
//
//  Created by yuanshengcao on 16/9/13.
//  Copyright © 2016年 Xmartlabs. All rights reserved.
//

import Foundation
import Eureka

//MARK: FormatterExample

class FormatterExample : FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("Number formatters")
            <<< DecimalRow(){
                $0.useFormatterDuringInput = true
                $0.title = "Currency style"
                $0.value = 2015
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
            }
            <<< DecimalRow(){
                $0.title = "Scientific style"
                $0.value = 2015
                let formatter = NSNumberFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .ScientificStyle
                $0.formatter = formatter
            }
            <<< IntRow(){
                $0.title = "Spell out style"
                $0.value = 2015
                let formatter = NSNumberFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .SpellOutStyle
                $0.formatter = formatter
            }
            +++ Section("Date formatters")
            <<< DateRow(){
                $0.title = "Short style"
                $0.value = NSDate()
                let formatter = NSDateFormatter()
                formatter.locale = .currentLocale()
                formatter.dateStyle = .ShortStyle
                $0.dateFormatter = formatter
            }
            <<< DateRow(){
                $0.title = "Long style"
                $0.value = NSDate()
                let formatter = NSDateFormatter()
                formatter.locale = .currentLocale()
                formatter.dateStyle = .LongStyle
                $0.dateFormatter = formatter
            }
            +++ Section("Other formatters")
            <<< DecimalRow(){
                $0.title = "Energy: Jules to calories"
                $0.value = 100.0
                let formatter = NSEnergyFormatter()
                $0.formatter = formatter
            }
            <<< IntRow(){
                $0.title = "Weight: Kg to lb"
                $0.value = 1000
                $0.formatter = NSMassFormatter()
        }
    }
    
    class CurrencyFormatter : NSNumberFormatter, FormatterProtocol {
        override func getObjectValue(obj: AutoreleasingUnsafeMutablePointer<AnyObject?>, forString string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>) -> Bool {
            guard obj != nil else { return false }
            let str = string.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator("")
            obj.memory = NSNumber(double: (Double(str) ?? 0.0)/Double(pow(10.0, Double(minimumFractionDigits))))
            return true
        }
        
        func getNewPosition(forPosition position: UITextPosition, inTextInput textInput: UITextInput, oldValue: String?, newValue: String?) -> UITextPosition {
            return textInput.positionFromPosition(position, offset:((newValue?.characters.count ?? 0) - (oldValue?.characters.count ?? 0))) ?? position
        }
    }
}
