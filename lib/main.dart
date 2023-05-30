import 'package:abotoapp/shared/audio_provider.dart';
import 'package:abotoapp/welcome/welcome.dart';
import 'package:abotoapp/route.dart';
import 'package:abotoapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AudioProvider(), child: const Main()));
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      routes: appRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
