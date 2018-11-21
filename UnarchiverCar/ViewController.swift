//
//  ViewController.swift
//  UnarchiverCar
//
//  Created by Jater on 2018/11/12.
//  Copyright © 2018年 Jater. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, JAFilePathChooseDelegate {
    
    @IBOutlet weak var inputView: JAInputView!
    
    @IBOutlet weak var exportView: JAExportView!
    
    @IBOutlet weak var getButton: NSButton!
    private var inputFilePath : String = ""
    private var exportFilePath : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.inputView.delegate = self
        self.exportView.delegate = self
        
        getButton.isEnabled = false
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func chooseFilePath(filePath: String, isInput: Bool) {
        if isInput {
            self.inputFilePath = filePath
        } else {
            self.exportFilePath = filePath
        }
        checkButtonStatus()
    }
    
    func checkButtonStatus() {
        if self.inputFilePath.count > 0 && self.exportFilePath.count > 0 {
            getButton.isEnabled = true
        } else {
            getButton.isEnabled = false
        }
    }
    @IBAction func getButtonAction(_ sender: NSButton) {
        exportCarFileAtPath()
    }
    
    func exportCarFileAtPath() -> Void {
        let service = JAUnarchiverService.init()
        service.exportCarFile(atPath: self.inputFilePath, toExportPath: self.exportFilePath)
    }
}
