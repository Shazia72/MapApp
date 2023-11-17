//  Created by Shazia Vohra on 2023-11-11.

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .accentColor(Color.pink)
            .onAppear{
                viewModel.checkIfLocationServIsEnabled()
            }
        .mapStyle(.hybrid(elevation: .realistic))
    }
}

#Preview {
    ContentView()
}
