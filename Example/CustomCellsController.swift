//
//  CustomCellsController.swift
//  Example
//
//  Created by yuanshengcao on 16/9/13.
//  Copyright © 2016年 Xmartlabs. All rights reserved.
//

import UIKit
import Eureka
import CoreLocation

//MARK: Custom Cells Example

class CustomCellsController : FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++
            Section() {
                var header = HeaderFooterView<EurekaLogoViewNib>(HeaderFooterProvider.NibFile(name: "EurekaSectionHeader", bundle: nil))
                header.onSetupView = { (view, section) -> () in
                    view.imageView.alpha = 0;
                    UIView.animateWithDuration(2.0, animations: { [weak view] in
                        view?.imageView.alpha = 1
                        })
                    view.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1)
                    UIView.animateWithDuration(1.0, animations: { [weak view] in
                        view?.layer.transform = CATransform3DIdentity
                        })
                }
                $0.header = header
            }
            +++ Section("WeekDay cell")
            
            <<< WeekDayRow(){
                $0.value = [.Monday, .Wednesday, .Friday]
            }
            
            <<< TextFloatLabelRow() {
                $0.title = "Float Label Row, type something to see.."
            }
            
            <<< IntFloatLabelRow() {
                $0.title = "Float Label Row, type something to see.."
        }
    }
}
