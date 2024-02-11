//
//  main.swift
//  polysloth
//
//  Created by Denis Ronchese on 07/02/24.
//

import Cocoa

// Assume AppDelegate is defined in another file.
let delegate = AppDelegate() // Initialize the AppDelegate.
let application = NSApplication.shared // Get the shared application instance.
application.delegate = delegate // Assign the delegate.
application.run() // Run the application.
