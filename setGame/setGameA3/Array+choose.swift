//
//  Array+choose.swift
//  setGameA3
//
//  Created by Sahil Sahu on 05/05/21.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching element: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == element.id {
                return index
            }
        }
        return nil
    }
}
