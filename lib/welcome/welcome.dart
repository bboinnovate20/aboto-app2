import 'package:flutter/material.dart';

class WelcomeSplash extends StatefulWidget {
  const WelcomeSplash({super.key});

  @override
  State<WelcomeSplash> createState() => _WelcomeSplashState();
}

class _WelcomeSplashState extends State<WelcomeSplash> {
  double _opacity = 0;
  double _top = -20.0;
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _opacity = 1;
          _top = 0.0;
        }));

    Future.delayed(const Duration(seconds: 7))
        .then((value) => Navigator.pushNamed(context, '/dashboard'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              opacity: _opacity,
              child: const Image(
                  image: AssetImage('images/logo.webp'),
                  height: 180,
                  fit: BoxFit.contain),
            ),
            SizedBox(
              height: 100,
              width: 200,
              child: Stack(
                children: [
                  AnimatedPositioned(
                      top: _top,
                      duration: const Duration(seconds: 1),
                      child: AnimatedOpacity(
                          duration: const Duration(seconds: 2),
                          opacity: _opacity,
                          child: const Image(
                            image: AssetImage('images/arabicnn.png'),
                            width: 200,
                          )))
                ],
              ),
            )

            // AspectRatio(
            //   aspectRatio: 200 / 200,
            //   child: Image(
            //       image: AssetImage('images/logo.webp'), fit: BoxFit.contain),
            // )
          ],
        ));
    //   backgroundColor: Theme.of(context).colorScheme.background,
    //   body: const Center(
    //     child: Image(
    //       image: AssetImage('images/logo.webp'),
    //       height: 200,
    //       fit: BoxFit.contain,
    //     ),
    //   ),
    // );
  }
}
