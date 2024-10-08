import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_app/resources/auth_method.dart';
import 'package:meeting_app/screens/history_meeting_screen.dart';
import 'package:meeting_app/screens/meeting_screen.dart';
import 'package:meeting_app/utils/colors.dart';
import 'package:meeting_app/widgets/custom_button.dart';
import 'package:meeting_app/widgets/home_meeting_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;

  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    MeetingScreen(),
    const HistoryMeetingScreen(),
    CustomButton(text: 'Log out', onPressed: () => AuthMethods().signOut())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('Meeting'),
        centerTitle: true,
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: footerColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: onPageChanged,
          currentIndex: _page,
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 14,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.comment_bank,
                ),
                label: 'Meet & chat'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.lock_clock,
                ),
                label: 'Meetings'),
            // BottomNavigationBarItem(
            //     icon: Icon(
            //       Icons.person_outline,
            //     ),
            //     label: 'Contacts'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.logout,
                ),
                label: 'Log out'),
          ]),
    );
  }
}
