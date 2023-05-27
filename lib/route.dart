import 'package:abotoapp/dashboard/home.dart';
import 'package:abotoapp/dashboard/lectures.dart';
import 'package:abotoapp/welcome/welcome.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  // '/': (context) => const WelcomeSplash(),
  // '/dashboard': (context) => const Dashboard()

  //experiment
  // '/': (context) => const Dashboard(),
  '/': (context) => const AllLectures()
};
