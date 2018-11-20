//
//  JAInputView.swift
//  UnarchiverCar
//
//  Created by Jater on 2018/11/20.
//  Copyright © 2018年 Jater. All rights reserved.
//

import Cocoa

class JAInputView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.registerForDraggedTypes([NSPasteboard])
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
}
