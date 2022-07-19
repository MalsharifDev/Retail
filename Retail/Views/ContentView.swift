//
//  ContentView.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/15/22.
//

import SwiftUI
import Combine

struct ContentView: View {

    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }

    var body: some View {
        ProductLandingView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
