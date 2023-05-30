import 'package:abotoapp/dashboard/home.dart';
import 'package:abotoapp/dashboard/lectures.dart';
import 'package:abotoapp/dashboard/profile.dart';
import 'package:flutter/material.dart';
import 'package:abotoapp/dashboard/lecture_play_stack.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  // '/': (context) => const WelcomeSplash(),
  // '/dashboard': (context) => const Dashboard()

  //experiment
  '/': (context) => const Dashboard(),
  // '/lecturePlay': (context) => const LecturePlaying(),
  // '/profile': (context) => const ProfileAboto()
  // '/': (context) => const ProfileAboto()
  // '/': (context) => const AllLectures()

  // '/': (context) => const LecturePlaying(),
};
