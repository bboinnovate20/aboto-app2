import 'package:abotoapp/components.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [TopHeader(), Biography(), Lectures()],
      )),
    );
  }
}

class Lectures extends StatelessWidget {
  const Lectures({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 9),
                child: Text("Lectures",
                    style: Theme.of(context).textTheme.displayLarge)),
            Row(
              children: const [
                LectureUI(
                  title: "Ifaseyin Ilekewu Ati Majemu",
                  timing: "2hr 4sec",
                ),
                LectureUI(title: "Titobi Olohun", timing: "2hr 4sec")
              ],
            )
          ],
        ));
  }
}

class Biography extends StatelessWidget {
  const Biography({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(children: [
            const Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Image(
                  image: AssetImage('images/logo.webp'),
                  height: 110,
                  // fit: BoxFit.contain
                )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Sheikh Alhaji AbdulGaniyy Aboto",
                    style: Theme.of(context).textTheme.bodyLarge),
                const Text(
                  "DHUL NURAYN",
                  style: TextStyle(
                    color: Colors.white60,
                  ),
                ),
                const Text("(LIFE & DEATH)"),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                        onPressed: () => {print('ddd')},
                        child: Text("View Profile",
                            style: Theme.of(context).textTheme.bodyMedium)))
              ],
            ))
          ]),
        ));
  }
}

class TopHeader extends StatelessWidget {
  const TopHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Salam Alaykum!",
                      style: Theme.of(context).textTheme.bodyMedium),
                  Icon(FontAwesomeIcons.gear,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 20)
                ],
              ),
              const SearchBar()
            ],
          ),
        )));
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 13),
      child: const TextField(
        style: TextStyle(fontSize: 19),
        decoration: InputDecoration(
            // icon: Icon(FontAwesomeIcons.magnifyingGlass),

            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide.none,
            ),
            filled: true,
            hintText: 'Search for lecture',
            fillColor: Colors.white),
      ),
    );
  }
}
