import 'package:flutter/material.dart';
import 'package:my_first_app/app.dart';
import 'package:my_first_app/services/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = AppSettings();
  await settings.init();
  runApp(ToolboxApp(settings: settings));
}
