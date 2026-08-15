//
//  ContentView.swift
//  order-up
//
//  Created by YJ Soon on 14/8/26.
//

import SwiftUI

struct ContentView: View {
    @State private var items: [MenuItem] = [
        MenuItem(name: "🥤  Milo", price: 1.50, color: .orange, quantity: 0),
        MenuItem(name: "🍵  Teh", price: 1.20, color: .brown, quantity: 0),
        MenuItem(name: "🍞  Kaya Toast", price: 2.00, color: .yellow, quantity: 0),
    ]
    @State private var flag = false
    @State private var placed = false
    @State private var finalised = false
    @State private var tmp = 0
    @State private var arr: [String] = []

    private var orderSummary: String {
        items.filter { $0.quantity > 0 }
            .map { "\($0.name) x\($0.quantity)" }
            .joined(separator: "\n")
    }

    private var total: Double {
        items.reduce(0) { $0 + $1.price * Double($1.quantity) }
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Order Up")
                .font(.largeTitle)
                .bold()

            Text("Kopitiam snacks. Tap + to add.")
                .font(.title3)
                .foregroundStyle(.secondary)

            ForEach($items) { $item in
                ItemRow(item: $item)
            }

            Text("Total  $\(total, specifier: "%.2f")")
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
                        for index in items.indices {
                            items[index].quantity = 0
                        }
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
