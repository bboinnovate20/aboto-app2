import 'package:abotoapp/shared/audio_provider.dart';
import 'package:abotoapp/route.dart';
import 'package:abotoapp/shared/page_manager.dart';
import 'package:abotoapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  await audioService();
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
    getIt<PlayListManager>().init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _buildTheme(Brightness.light),
      routes: appRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = appTheme;

  return baseTheme.copyWith(
    textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
  );
}

GetIt getIt = GetIt.instance;

audioService() async {
  getIt.registerSingleton<AudioProviderService>(await initAudioHandler());
  getIt.registerSingleton<PlayListManager>(PlayListManager());
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
}
