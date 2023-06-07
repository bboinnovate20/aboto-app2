import 'package:abotoapp/dashboard/about.dart';
import 'package:abotoapp/dashboard/favourite.dart';
import 'package:abotoapp/shared/audio_provider.dart';
import 'package:abotoapp/shared/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:abotoapp/dashboard/dashboard.dart';
import 'package:abotoapp/dashboard/lectures.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

GetIt getIt = GetIt.instance;
final PlayListManager _playerControl = getIt<PlayListManager>();
final _audioForStream = getIt<AudioProviderService>();

class DashboardMain extends StatefulWidget {
  const DashboardMain({super.key});

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  late PageController _pageController;
  late ScrollController _scrollController;
  late Widget currentScreen;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: <Widget>[
                MainScroll(
                    action: () {
                      setState(() {
                        _index = 1;
                      });
                      onChange(1);
                    },
                    controller: _scrollController),
                const AllLectures(),
                const FavouriteLectures(),
                const About()
              ],
            ),
            const BottomPlayingNav(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                  gap: 4,
                  activeColor: Theme.of(context).primaryColor,
                  iconSize: 18,
                  selectedIndex: _index,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.blueGrey[50]!,
                  color: Colors.black.withOpacity(.5),
                  onTabChange: (index) => onChange(index),
                  tabs: const [
                    GButton(icon: FontAwesomeIcons.house, text: 'Home'),
                    GButton(icon: FontAwesomeIcons.music, text: 'Lectures'),
                    GButton(
                        icon: FontAwesomeIcons.solidHeart, text: 'Favourite'),
                    GButton(icon: FontAwesomeIcons.info, text: 'About')
                  ]),
            ),
          ),
        ));
  }

  void onChange(index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 50),
        curve: Curves.fastLinearToSlowEaseIn);
    setState(() {
      _index = index;
    });
  }
}

class BottomPlayingNav extends StatefulWidget {
  const BottomPlayingNav({super.key});
  @override
  State<BottomPlayingNav> createState() => _BottomPlayingNavState();
}

class _BottomPlayingNavState extends State<BottomPlayingNav> {
  late bool showBottomPlay;
  @override
  void initState() {
    super.initState();
    setState(() {
      showBottomPlay = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _playerControl.bottomStateNotifier,
      builder: (context, value, child) {
        // _playerControl.playButtonNotifier.value
        if (!value.idle) {
          return Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            height: 50,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).colorScheme.secondary),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(FontAwesomeIcons.music, color: Colors.white70),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: Text(value.title,
                            // _playerControl
                            //     .currentSongTitleNotifier.value,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: _playerControl.isFirstSongNotifier,
                            builder: (context, value, _) => GestureDetector(
                              onTap: () => _playerControl.previous(),
                              child: Icon(FontAwesomeIcons.backward,
                                  color: value ? Colors.white38 : Colors.white,
                                  size: 18),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: _playerControl.isPlayingNotifier,
                            builder: (context, value, _) => GestureDetector(
                              onTap: () => _playerControl.play(),
                              child: Icon(
                                  value
                                      ? FontAwesomeIcons.pause
                                      : FontAwesomeIcons.play,
                                  color: Colors.white,
                                  size: 18),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: _playerControl.isLastSongNotifier,
                            builder: (context, value, _) => GestureDetector(
                              onTap: () {
                                _playerControl.next();
                              },
                              child: Icon(FontAwesomeIcons.forward,
                                  color: value ? Colors.white38 : Colors.white,
                                  size: 18),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() {
                              showBottomPlay = false;
                              _playerControl.stop();
                            }),
                            child: const Icon(FontAwesomeIcons.xmark,
                                color: Colors.white, size: 18),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
