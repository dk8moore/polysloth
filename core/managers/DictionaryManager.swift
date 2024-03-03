//
//  DictionaryManager.swift
//  polysloth
//
//  Created by Denis Ronchese on 14/02/24.
//

import Foundation

class DictionaryManager {
    func definition(for word: String) -> String? {
        let range = CFRangeMake(0, word.utf16.count)
        guard let definition = DCSCopyTextDefinition(nil, word as CFString, range) else { return nil }
        return String(definition.takeRetainedValue())
    }
}
