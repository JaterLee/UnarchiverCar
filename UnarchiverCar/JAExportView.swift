//
//  JAExportView.swift
//  UnarchiverCar
//
//  Created by Jater on 2018/11/21.
//  Copyright © 2018年 Jater. All rights reserved.
//

import Cocoa

class JAExportView: JAInputView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.placeholdStaticExitedString = "请将输出文件拖放此处"
        self.placeholdStaticEnteredString = "松手设置输出文件夹路径"
        self.folderImageView.image = NSImage.init(named: NSImage.folderName)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        self.changePlaceHolderStatus(status: JAPlaceholdStatus.Hidden)
        let pasteboard = sender.draggingPasteboard
        let fileStr = pasteboard.propertyList(forType: .fileURL)
        let fileUrl = URL.init(string: fileStr as! String)
        let path = self.urlDecodedString(string: (fileUrl?.absoluteString)!)
        self.filePathLabel.stringValue = ""
        self.filePathLabel.stringValue = path
        delegate?.chooseFilePath(filePath: path, isInput: false)
        return true
    }
}
