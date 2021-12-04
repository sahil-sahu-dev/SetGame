//
//  setGameA3App.swift
//  setGameA3
//
//  Created by Sahil Sahu on 02/05/21.
//

import SwiftUI

@main
struct setGameA3App: App {
    var body: some Scene {
        WindowGroup {
            setGameView(viewModel: SetViewModel())
        }
    }
}
