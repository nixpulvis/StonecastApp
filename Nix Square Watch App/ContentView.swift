//
//  ContentView.swift
//  Nix Square Watch App
//
//  Created by Nathan Lilienthal on 2/23/23.
//

import SwiftUI

class RandomGauge: ObservableObject {
    @Published var currentValue: Double
    @State private var minValue = 0.0
    @State private var maxValue = 170.0

    init() {
        self.currentValue = -1.0
        self.update()
        let _timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print(self.currentValue)
            self.update()
        }
    }
    
    func update() {
        self.currentValue = Double.random(in: 0.0...170.0)
    }
    
    func view() -> GaugeView {
        return GaugeView(obj: self)
    }
    
    struct GaugeView: View {
        @ObservedObject var obj: RandomGauge

        var body: some View {
            Gauge(value: obj.currentValue, in: obj.minValue...obj.maxValue) {
                Text("TODO constructor value")
            } currentValueLabel: {
                Text("\(Int(obj.currentValue))")
            } minimumValueLabel: {
                Text("\(Int(obj.minValue))")
            } maximumValueLabel: {
                Text("\(Int(obj.maxValue))")
            }.gaugeStyle(.circular)
        }
    }
}





struct ContentView: View {
    var randomGauge = RandomGauge()
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "thermometer.sun.fill")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("STONECAST")
            }
            Spacer()
            randomGauge.view()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
