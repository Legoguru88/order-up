import SwiftUI

struct MenuItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let color: Color
    var quantity: Int
}

struct ItemRow: View {
    @Binding var item: MenuItem

    var body: some View {
        HStack {
            Text(item.name)
                .font(.title2)
            Text("$\(item.price, specifier: "%.2f")")
                .foregroundStyle(.secondary)
            Spacer()
            Text("\(item.quantity)")
                .font(.title)
                .monospacedDigit()
            Button {
                if item.quantity > 0 {
                    item.quantity -= 1
                }
            } label: {
                Image(systemName: "minus.circle.fill")
                    .font(.largeTitle)
            }
            Button {
                item.quantity += 1
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
            }
        }
        .padding()
        .background(item.color.opacity(0.18))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}