import 'dart:ui';

import 'package:abotoapp/dashboard/lectures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LecturePlaying extends StatelessWidget {
  const LecturePlaying({super.key});

  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)!.settings.arguments ??
        <String, String>{}) as Map;

    return Scaffold(
        body: SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.secondary,
        ])),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, right: 8.0, left: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customAppBar(
                context,
                args['title'],
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 85, bottom: 20),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage('images/logo.webp'),
                          height: 200,
                          // fit: BoxFit.contain
                        ),
                      ),
                    ),
                    Text(
                      args['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      "Sheikh Abdul Ganiyy Aboto",
                      style: TextStyle(height: 2.0),
                    ),
                  ],
                ),
              ),
              const Favourite()
            ],
          ),
        ),
      ),
    ));
  }
}

Widget customAppBar(BuildContext context, text) {
  return Row(
    children: [
      InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(FontAwesomeIcons.chevronLeft, color: Colors.white)),
      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            '$text',
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      )
    ],
  );
}

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200));
  late final Animation<double> _animation;

  late bool isLike;
  @override
  void initState() {
    super.initState();
    _animation =
        // CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
        Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
    isLike = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(onTap: () => onTap(), child: likeTransition(isLike)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Divider(
              color: Colors.white,
              height: 5,
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.backward,
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Icon(
                  FontAwesomeIcons.play,
                  color: Colors.white,
                ),
              ),
              Icon(
                FontAwesomeIcons.forward,
                color: Colors.white,
              )
            ],
          )
        ],
      ),
    );
  }

  onTap() {
    setState(() {
      isLike = !isLike;
      _controller.reset();
      _controller.forward();
    });
  }

  ScaleTransition likeTransition(bool isLike) {
    return ScaleTransition(
      scale: _animation,
      child: Icon(
        isLike ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
        color: isLike ? Colors.red : Colors.white,
        size: 50,
      ),
    );
  }
}
