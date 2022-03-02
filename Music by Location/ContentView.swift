//
//  ContentView.swift
//  Music by Location
//
//  Created by Begg, Alistair (AMM) on 02/03/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationHandler = LocationHandler()
    
    var body: some View {
        VStack {
            Form {
                Text(locationHandler.lastKnownLocation)
                    .padding()
            }
            Button("Find Music", action: {
                locationHandler.requestLocation()
            })
        }.onAppear(perform: {
            locationHandler.requestAuthorisation()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
