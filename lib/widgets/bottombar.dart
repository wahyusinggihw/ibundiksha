import 'package:flutter/material.dart';
import 'package:ibundiksha/screens/home.dart';
import 'package:ibundiksha/screens/profile.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  // final NotificationHelper _notificationHelper = NotificationHelper();

  int pageIndex = 0;
  final List<Widget> listPage = [
    const HomeScreen(),
    const HomeScreen(),
    const ProfileScreen(),
  ];

  @override
  // void dispose() {
  //   selectNotificationSubject.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // _notificationHelper
    //     .configureSelectNotificationSubject(context,'/detail');
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Stack(
          children: [
            listPage.elementAt(pageIndex),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.05),
              child: Align(
                alignment: const Alignment(0.0, 1.1),
                child: BottomNavigationBar(
                  selectedItemColor: Colors.cyan,
                  unselectedItemColor: Colors.grey,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  backgroundColor: Colors.cyan.shade50,
                  currentIndex: pageIndex,
                  onTap: (int index) {
                    setState(() {
                      pageIndex = index;
                    });
                    print(index);
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings_outlined),
                        activeIcon: Icon(Icons.settings),
                        label: 'Setting'),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.qr_code_scanner_outlined,
                          color: Colors.transparent,
                        ),
                        activeIcon: Icon(Icons.qr_code_scanner_rounded),
                        label: ''),
                    BottomNavigationBarItem(
                        activeIcon: Icon(Icons.account_circle_rounded),
                        icon: Icon(Icons.account_circle_outlined),
                        label: 'Profile'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Align(
                alignment: const Alignment(0.0, 1.1),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: GestureDetector(
                    child: Icon(
                      Icons.qr_code_scanner_rounded,
                      size: 40,
                      color: pageIndex == 1 ? Colors.white : Colors.white38,
                    ),
                    onTap: () {
                      setState(() {
                        pageIndex = 1;
                      });
                      // print('qrscan');
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
