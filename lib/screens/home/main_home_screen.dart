import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../utils/constants/constants.dart';
import '../../utils/colors/custom_colors.dart';
import 'subpages/home_subpage.dart';
import 'subpages/leader_board_subpage.dart';
import 'subpages/profile_subpage.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 1;

  void goToPage(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    LeaderBoardSubpage(),
    HomeSubpage(),
    ProfileSubpage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Padding _buildBody() => Padding(padding: const EdgeInsets.all(20), child: _pages[_currentIndex]);

  Container _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: const BorderRadius.vertical(top: Radius.circular(40))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: _buildGNav(),
      ),
    );
  }

  GNav _buildGNav() {
    return GNav(
      gap: 8,
      activeColor: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      duration: const Duration(milliseconds: 400),
      tabBackgroundColor: CustomColors.buttonColor,
      color: CustomColors.buttonColor2,
      tabs: [
        _buildGButton(Icons.leaderboard_outlined, LocaleConstants.leaders.tr()),
        _buildGButton(Icons.home_outlined, LocaleConstants.home.tr()),
        _buildGButton(Icons.person_outline_rounded, LocaleConstants.profile.tr()),
      ],
      selectedIndex: _currentIndex,
      onTabChange: (index) => goToPage(index),
    );
  }

  GButton _buildGButton(IconData icon, String text) => GButton(icon: icon, text: text);
}
