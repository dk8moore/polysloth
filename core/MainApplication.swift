//
//  MainApplication.swift
//  polysloth
//
//  Created by Denis Ronchese on 07/02/24.
//

import Cocoa

class MainApplication: NSApplication {
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func run() {
        self.delegate?.applicationWillFinishLaunching?(Notification(name: Notification.Name("WillFinishLaunching")))
        self.delegate?.applicationDidFinishLaunching?(Notification(name: Notification.Name("DidFinishLaunching")))
        self.delegate?.applicationWillTerminate?(Notification(name: Notification.Name("WillTerminate")))
        self.finishLaunching()
        super.run()
    }
}

