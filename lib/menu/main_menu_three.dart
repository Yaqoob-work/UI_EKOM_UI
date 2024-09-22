import 'dart:convert';
import 'package:mobi_tv_entertainment/menu_one_item/splash_screen.dart';
import 'package:http/http.dart' as https;
import 'package:flutter/material.dart';

import '../home_sub_screen/sub_vod.dart';
import '../live_sub_screen/entertainment_screen.dart';
import '../live_sub_screen/religious_screen.dart';
import '../live_sub_screen/sports_screen.dart';
import 'top_navigation_bar_three.dart';
import 'top_navigation_bar_two.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        // '/myhome': (context) => MyHomePage(),
        // '/category': (context) => HomeCategory(),
        // '/search': (context) => SearchScreen(),
        // '/vod': (context) => VOD(),
        '/mainmenuthree': (context) => MainMenuThree(),
        // '/live': (context) => AllChannel(),
      },
    );
  }
}

class MainMenuThree extends StatefulWidget {
  @override
  _MainMenuThreeState createState() => _MainMenuThreeState();
}

class _MainMenuThreeState extends State<MainMenuThree> {
  int _selectedPage = 0;
  late PageController _pageController;
  bool _tvenableAll = false; // Track tvenableAll status

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedPage);
    _fetchTvenableAllStatus(); // Fetch tvenableAll status
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageSelected(int index) {
    setState(() {
      _selectedPage = index;
    });
    _pageController.jumpToPage(index);
  }

  Future<void> _fetchTvenableAllStatus() async {
    try {
      final response = await https.get(
        Uri.parse('https://api.ekomflix.com/android/getSettings'),
        headers: {
          'x-api-key': 'vLQTuPZUxktl5mVW',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _tvenableAll = data['tvenableAll'] == 1;
        });
      } else {
        print('Failed to load settings');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      // Your LiveScreen content pages
      // HomeScreen(),
      // NewsScreen(),
      // MovieScreen(),
      // MusicScreen(),
      SubVod(),
      ReligiousScreen(),
      EntertainmentScreen(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedPage = index;
                });
              },
              children: pages,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopNavigationBarThree(
              selectedPage: _selectedPage,
              onPageSelected: _onPageSelected,
              tvenableAll: _tvenableAll,
            ),
          ),
        ],
      ),
    );
  }
}
