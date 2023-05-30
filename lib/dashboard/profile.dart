import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileAboto extends StatelessWidget {
  const ProfileAboto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(FontAwesomeIcons.chevronLeft)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              paragraph("Early Life",
                  "The early life was that he went for, The early life was that he went for, The early life was that he went for, The early life was that he went for, The early life was that he went for"),
              paragraph("Early Life",
                  "The early life was that he went for, The early life was that he went for, The early life was that he went for, The early life was that he went for, The early life was that he went for"),
              paragraph("Early Life",
                  "The early life was that he went for, The early life was that he went for, The early life was that he went for, The early life was that he went for, The early life was that he went for"),
              paragraph("Early Life",
                  "The early life was that he went for, The early life was that he went for, The early life was that he went for, The early life was that he went for, The early life was that he went for"),
              paragraph("Early Life",
                  "The early life was that he went for, The early life was that he went for, The early life was that he went for, The early life was that he went for, The early life was that he went for"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget paragraph(title, message) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const Divider(
          height: 30,
        ),
        Text(
          message,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        )
      ],
    ),
  );
}
