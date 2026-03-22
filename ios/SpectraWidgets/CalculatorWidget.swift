import WidgetKit
import SwiftUI

struct CalculatorWidgetEntryView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "6C5CE7"), Color(hex: "A855F7")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            VStack(spacing: 8) {
                Image(systemName: "plus.forwardslash.minus")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                Text("計算機")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
            }
        }
        .widgetURL(URL(string: "spectra://tools/calculator"))
    }
}

struct CalculatorWidget: Widget {
    let kind: String = "CalculatorWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SimpleTimelineProvider()) { _ in
            CalculatorWidgetEntryView()
        }
        .configurationDisplayName("計算機")
        .description("快速打開 Spectra 計算機")
        .supportedFamilies([.systemSmall])
    }
}
