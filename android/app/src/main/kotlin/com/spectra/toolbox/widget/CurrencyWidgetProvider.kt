package com.spectra.toolbox.widget

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.widget.RemoteViews
import com.spectra.toolbox.R

class CurrencyWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.currency_widget_layout)

            // Read shared data from home_widget SharedPreferences
            val prefs = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE)
            val from = prefs.getString("currency_from", null)
            val to = prefs.getString("currency_to", null)
            val rate = prefs.getString("currency_rate", null)
            val updated = prefs.getString("currency_updated", null)

            if (from != null && to != null && rate != null) {
                views.setTextViewText(R.id.currency_pair, "$from → $to")
                views.setTextViewText(R.id.currency_rate, rate)
                val timeText = if (updated != null) {
                    try {
                        val instant = java.time.Instant.parse(updated)
                        val formatter = java.time.format.DateTimeFormatter
                            .ofPattern("MM/dd HH:mm")
                            .withZone(java.time.ZoneId.systemDefault())
                        "更新: ${formatter.format(instant)}"
                    } catch (e: Exception) {
                        ""
                    }
                } else ""
                views.setTextViewText(R.id.currency_updated, timeText)
                views.setViewVisibility(R.id.data_container, android.view.View.VISIBLE)
                views.setViewVisibility(R.id.placeholder_container, android.view.View.GONE)
            } else {
                views.setViewVisibility(R.id.data_container, android.view.View.GONE)
                views.setViewVisibility(R.id.placeholder_container, android.view.View.VISIBLE)
            }

            val intent = Intent(Intent.ACTION_VIEW, Uri.parse("spectra://tools/currency-converter"))
            val pendingIntent = PendingIntent.getActivity(
                context, 1, intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.widget_container, pendingIntent)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
