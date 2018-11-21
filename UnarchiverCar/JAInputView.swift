//
//  JAInputView.swift
//  UnarchiverCar
//
//  Created by Jater on 2018/11/20.
//  Copyright © 2018年 Jater. All rights reserved.
//

import Cocoa

protocol JAFilePathChooseDelegate {
    func chooseFilePath(filePath : String, isInput : Bool)
}

class JAInputView: NSView {
    public var filePathLabel : NSTextField = NSTextField.init()
    public var fileDragStatusLabel : NSTextField = NSTextField.init()
    public var folderImageView : NSImageView = NSImageView.init(image: NSImage.init(named: NSImage.multipleDocumentsName)!)
    
    public var placeholdStaticExitedString : String = "将您需要提取的资源包拖放到这里"
    public var placeholdStaticEnteredString : String = "松手提取当前资源包"
    
    public var delegate : JAFilePathChooseDelegate?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.filePathLabel.isEditable = false
        self.filePathLabel.alignment = NSTextAlignment.center
        self.filePathLabel.textColor = NSColor.darkGray
        self.filePathLabel.font = NSFont.systemFont(ofSize: 20)
        self.filePathLabel.drawsBackground = false
        self.filePathLabel.frame = NSMakeRect(0, 0, NSWidth(self.frame), NSHeight(self.frame)-50);
        self.addSubview(self.filePathLabel)
        
        self.fileDragStatusLabel.font = NSFont.systemFont(ofSize: 18)
        self.fileDragStatusLabel.alignment = NSTextAlignment.center
        self.fileDragStatusLabel.isBordered = false
        self.fileDragStatusLabel.isEditable = false
        self.fileDragStatusLabel.isSelectable = false
        self.fileDragStatusLabel.frame = NSMakeRect(1, 1, NSWidth(self.frame)-2, 30)
        self.addSubview(self.fileDragStatusLabel)
        
        self.addSubview(self.folderImageView)
        self.folderImageView.frame = NSMakeRect(NSWidth(self.frame)/2-25, NSHeight( self.filePathLabel.frame), 50, 50);
        
        self.changePlaceHolderStatus(status: JAPlaceholdStatus.ShowExited)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.cgColor
        self.registerForDraggedTypes([.fileURL])
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        self.changePlaceHolderStatus(status: JAPlaceholdStatus.ShowEntered)
        let pboard = sender.draggingPasteboard
        if pboard.types?.contains(.fileURL) ?? false {
            return NSDragOperation.copy
        }
        return NSDragOperation.link
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        self.changePlaceHolderStatus(status: JAPlaceholdStatus.ShowExited)
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        self.changePlaceHolderStatus(status: JAPlaceholdStatus.Hidden)
        let zPasteboard = sender.draggingPasteboard
        let list = zPasteboard.propertyList(forType: .fileURL)
        let file = URL.init(string: list as! String)
        let deFile = self.urlDecodedString(string: (file?.absoluteString)!);
        self.filePathLabel.stringValue = ""
        self.filePathLabel.stringValue = deFile
        delegate?.chooseFilePath(filePath: deFile, isInput: true)
        return true
    }
    
    enum JAPlaceholdStatus {
        case ShowExited
        case ShowEntered
        case Hidden
    }
    
    public func changePlaceHolderStatus(status : JAPlaceholdStatus) -> Void {
        if self.filePathLabel.stringValue.count > 0 && status == JAPlaceholdStatus.ShowExited {
            return
        }
        switch status {
        case .ShowExited:
            self.fileDragStatusLabel.isHidden = false
            self.fileDragStatusLabel.stringValue = self.placeholdStaticExitedString
            self.fileDragStatusLabel.textColor = NSColor.lightGray
            break
        case .ShowEntered:
            self.fileDragStatusLabel.isHidden = false
            self.fileDragStatusLabel.stringValue = self.placeholdStaticEnteredString;
            self.fileDragStatusLabel.textColor = NSColor.darkGray
            break
        case .Hidden:
            self.fileDragStatusLabel.isHidden = true
        }
    }
    
    public func urlDecodedString(string: String) -> String {
        let decodedString : String = string.removingPercentEncoding!;
        return decodedString;
    }
}

