//  ViewController.swift
//  Eureka ( https://github.com/xmartlabs/Eureka )
//
//  Copyright (c) 2016 Xmartlabs ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import Eureka
import CoreLocation

//MARK: HomeViewController

class HomeViewController : FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageRow.defaultCellUpdate = { cell, row in
            cell.accessoryView?.layer.cornerRadius = 17
            cell.accessoryView?.frame = CGRectMake(0, 0, 34, 34)
        }
        
        form =
            
            Section() {
                $0.header = HeaderFooterView<EurekaLogoView>(HeaderFooterProvider.Class)
            }
            
            <<< ButtonRow("Rows") {
                $0.title = $0.tag
                $0.presentationMode = .SegueName(segueName: "RowsExampleViewControllerSegue", completionCallback: nil)
            }
            
            <<< ButtonRow("Native iOS Event Form") { row in
                row.title = row.tag
                row.presentationMode = .SegueName(segueName: "NativeEventsFormNavigationControllerSegue", completionCallback:{  vc in vc.dismissViewControllerAnimated(true, completion: nil) })
            }
            
            <<< ButtonRow("Accesory View Navigation") { (row: ButtonRow) in
                row.title = row.tag
                row.presentationMode = .SegueName(segueName: "AccesoryViewControllerSegue", completionCallback: nil)
            }
            
            <<< ButtonRow("Custom Cells") { (row: ButtonRow) -> () in
                row.title = row.tag
                row.presentationMode = .SegueName(segueName: "CustomCellsControllerSegue", completionCallback: nil)
            }
            
            <<< ButtonRow("Customization of rows with text input") { (row: ButtonRow) -> Void in
                row.title = row.tag
                row.presentationMode = .SegueName(segueName: "FieldCustomizationControllerSegue", completionCallback: nil)
            }
            
            <<< ButtonRow("Hidden rows") { (row: ButtonRow) -> Void in
                row.title = row.tag
                row.presentationMode = .SegueName(segueName: "HiddenRowsControllerSegue", completionCallback: nil)
            }
            
            <<< ButtonRow("Disabled rows") { (row: ButtonRow) -> Void in
                row.title = row.tag
                row.presentationMode = .SegueName(segueName: "DisabledRowsControllerSegue", completionCallback: nil)
            }
            
            <<< ButtonRow("Formatters") { (row: ButtonRow) -> Void in
                row.title = row.tag
                row.presentationMode = .SegueName(segueName: "FormattersControllerSegue", completionCallback: nil)
            }
            
            <<< ButtonRow("Inline rows") { (row: ButtonRow) -> Void in
                row.title = row.tag
                row.presentationMode = .SegueName(segueName: "InlineRowsControllerSegue", completionCallback: nil)
            }
            <<< ButtonRow("List Sections") { (row: ButtonRow) -> Void in
                row.title = row.tag
                row.presentationMode = .SegueName(segueName: "ListSectionsControllerSegue", completionCallback: nil)
            }
            +++ Section()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "About"
                }  .onCellSelection({ (cell, row) in
                    self.showAlert()
                })
    }
    
    
    @IBAction func showAlert() {
        let alertController = UIAlertController(title: "OnCellSelection", message: "Button Row Action", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
}

//MARK: Emoji

typealias Emoji = String
let 👦🏼 = "👦🏼", 🍐 = "🍐", 💁🏻 = "💁🏻", 🐗 = "🐗", 🐼 = "🐼", 🐻 = "🐻", 🐖 = "🐖", 🐡 = "🐡"


class EurekaLogoViewNib: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class EurekaLogoView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imageView = UIImageView(image: UIImage(named: "Eureka"))
        imageView.frame = CGRect(x: 0, y: 0, width: 320, height: 130)
        imageView.autoresizingMask = .FlexibleWidth
        self.frame = CGRect(x: 0, y: 0, width: 320, height: 130)
        imageView.contentMode = .ScaleAspectFit
        self.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
