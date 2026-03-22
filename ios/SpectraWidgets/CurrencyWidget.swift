import WidgetKit
import SwiftUI

struct CurrencyEntry: TimelineEntry {
    let date: Date
    let fromCurrency: String?
    let toCurrency: String?
    let rate: String?
    let updated: String?
}

struct CurrencyTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> CurrencyEntry {
        CurrencyEntry(date: Date(), fromCurrency: "USD", toCurrency: "TWD", rate: "32.15", updated: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (CurrencyEntry) -> Void) {
        let entry = loadEntry()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CurrencyEntry>) -> Void) {
        let entry = loadEntry()
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }

    private func loadEntry() -> CurrencyEntry {
        let defaults = UserDefaults(suiteName: "group.com.spectra.toolbox")
        return CurrencyEntry(
            date: Date(),
            fromCurrency: defaults?.string(forKey: "currency_from"),
            toCurrency: defaults?.string(forKey: "currency_to"),
            rate: defaults?.string(forKey: "currency_rate"),
            updated: defaults?.string(forKey: "currency_updated")
        )
    }
}

struct CurrencyWidgetEntryView: View {
    var entry: CurrencyEntry

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "10B981"), Color(hex: "34D399")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            if let from = entry.fromCurrency,
               let to = entry.toCurrency,
               let rate = entry.rate {
                VStack(spacing: 4) {
                    Text("\(from) → \(to)")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                    Text(rate)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    if let updated = entry.updated,
                       let date = ISO8601DateFormatter().date(from: updated) {
                        Text(formatDate(date))
                            .font(.system(size: 10))
                            .foregroundColor(.white.opacity(0.6))
                    }
                }
            } else {
                VStack(spacing: 8) {
                    Image(systemName: "coloncurrencysign.arrow.circlepath")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                    Text("打開匯率換算")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                    Text("開始使用")
                        .font(.system(size: 10))
                        .foregroundColor(.white.opacity(0.6))
                }
            }
        }
        .widgetURL(URL(string: "spectra://tools/currency-converter"))
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd HH:mm"
        return "更新: \(formatter.string(from: date))"
    }
}

struct CurrencyWidget: Widget {
    let kind: String = "CurrencyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CurrencyTimelineProvider()) { entry in
            CurrencyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("匯率")
        .description("顯示最近匯率換算結果")
        .supportedFamilies([.systemSmall])
    }
}
