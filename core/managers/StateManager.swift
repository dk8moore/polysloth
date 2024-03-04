//
//  StateManager.swift
//  polysloth
//
//  Created by Denis Ronchese on 04/03/24.
//

import Foundation
import Combine

class StateManager: ObservableObject {
    // Define the various states of the application
    enum State: Equatable {
        case initial
        case history
        case translation
        case definition
        case rhymes
        case loading
        case error(String) // Include an error message
    }
    
    // Use @Published to notify the view of state changes
    @Published var currentState: State = .initial
}

