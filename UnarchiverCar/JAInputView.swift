//
//  JAInputView.swift
//  UnarchiverCar
//
//  Created by Jater on 2018/11/20.
//  Copyright © 2018年 Jater. All rights reserved.
//

import Cocoa

class JAInputView: NSView {
    private let titleLabel : NSTextField = NSTextField.init()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.cgColor
        self.registerForDraggedTypes([.fileURL])
        
        self.titleLabel.stringValue = "请拖入解压资源文件"
        self.titleLabel.alignment = NSTextAlignment.center
        self.titleLabel.textColor = NSColor.darkGray
        self.titleLabel.frame = NSMakeRect(0, 0, NSWidth(self.frame), NSHeight(self.frame));
        self.addSubview(self.titleLabel)
        
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let pboard = sender.draggingPasteboard
        if pboard.types?.contains(.fileURL) ?? false {
            return NSDragOperation.copy
        }
        return NSDragOperation.link

    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let zPasteboard = sender.draggingPasteboard
        let list = zPasteboard.propertyList(forType: .fileURL)
        let file = URL.init(string: list as! String)
        self.titleLabel.stringValue = file?.absoluteString ?? ""
        return true
    }
}

