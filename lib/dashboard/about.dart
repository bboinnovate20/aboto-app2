import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Align(
              alignment: Alignment.centerLeft,
              child: Text("About Alhaji Aboto App"))),
      body: const Padding(
        padding: EdgeInsets.only(right: 8.0, left: 8.0, top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/logo.webp'),
              height: 120,

              // fit: BoxFit.contain
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "This is Late Alhaji Aboto App, developed by one of the fan, if there is any suggested, you can reach out to me :)",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            )
          ],
        ),
      ),
    );
  }
}
