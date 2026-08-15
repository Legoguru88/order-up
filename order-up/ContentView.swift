//
//  ContentView.swift
//  order-up
//
//  Created by YJ Soon on 14/8/26.
//

import SwiftUI

struct ContentView: View {
    @State private var milo = 0
    @State private var teh = 0
    @State private var toast = 0
    @State private var flag = false
    @State private var placed = false
    @State private var finalised = false
    @State private var tmp = 0
    @State private var arr: [String] = []

    private var orderSummary: String {
        var parts: [String] = []
        if milo > 0 { parts.append("Milo x\(milo)") }
        if teh > 0 { parts.append("Teh x\(teh)") }
        if toast > 0 { parts.append("Kaya Toast x\(toast)") }
        return parts.joined(separator: "\n")
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Order Up")
                .font(.largeTitle)
                .bold()

            Text("Kopitiam snacks. Tap + to add.")
                .font(.title3)
                .foregroundStyle(.secondary)

            HStack {
                Text("🥤  Milo")
                    .font(.title2)
                Text("$1.50")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(milo)")
                    .font(.title)
                    .monospacedDigit()
                Button {
                    if milo > 0 {
                        milo -= 1
                    }
                    tmp = 1
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.largeTitle)
                }
                Button {
                    milo += 1
                    tmp = 1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                }
            }
            .padding()
            .background(Color.orange.opacity(0.18))
            .clipShape(RoundedRectangle(cornerRadius: 16))

            HStack {
                Text("🍵  Teh")
                    .font(.title2)
                Text("$1.20")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(teh)")
                    .font(.title)
                    .monospacedDigit()
                Button {
                    if teh > 0 {
                        teh -= 1
                    }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.largeTitle)
                }
                Button {
                    teh += 1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                }
            }
            .padding()
            .background(Color.brown.opacity(0.18))
            .clipShape(RoundedRectangle(cornerRadius: 16))

            HStack {
                Text("🍞  Kaya Toast")
                    .font(.title2)
                Text("$2.00")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(toast)")
                    .font(.title)
                    .monospacedDigit()
                Button {
                    if toast > 0 {
                        toast -= 1
                    }
                    arr.append("x")
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.largeTitle)
                }
                Button {
                    toast += 1
                    arr.append("x")
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                }
            }
            .padding()
            .background(Color.yellow.opacity(0.18))
            .clipShape(RoundedRectangle(cornerRadius: 16))

            Text("Total  $\(Double(milo) * 1.5 + Double(teh) * 1.2 + Double(toast) * 2.0, specifier: "%.2f")")
                .font(.title)
                .bold()
                .padding(.top, 8)

            Button("Place Order") {
                placed = true
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .font(.title2)

            if placed {
                Text(orderSummary)
                    .font(.title3)
                Button("Finalise Order") {
                    finalised = true
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
        }
        .padding(20)
        .fullScreenCover(isPresented: $finalised) {
            ZStack {
                Color.white.ignoresSafeArea()
                VStack(spacing: 20) {
                    Text("Order Placed!")
                        .font(.largeTitle)
                        .bold()
                    Text(orderSummary)
                        .font(.title3)
                    Button("Go Back") {
                        milo = 0
                        teh = 0
                        toast = 0
                        placed = false
                        finalised = false
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
