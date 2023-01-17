import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MenuHome {
  Color mainColor = Colors.cyan;
  Color subColor = Colors.cyan.shade100;
  Color strongColor = Colors.blue;

  static String active = "";

  static Widget mainContainer(
    BuildContext context, {
    double? width,
    double? height,
    Widget? child,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  static Widget mainWideContainer({
    double? width,
    double? height,
    Widget? child,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget menuGrid(
      BuildContext context, String title, IconData icon, String routeScreen) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.cyan.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: strongColor,
                  size: ResponsiveValue(context,
                      defaultValue: 60.0,
                      valueWhen: const [
                        Condition.smallerThan(name: MOBILE, value: 45.0),
                        Condition.smallerThan(name: TABLET, value: 40.0),
                        Condition.largerThan(name: TABLET, value: 80.0),
                      ]).value,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, routeScreen);
            active = title;
            if (kDebugMode) {
              print("aktif sekarang $active");
              print(routeScreen);
            }
          },
        ),
      ),
    );
  }

  static Widget bioBox(BuildContext context, String title, String subtitle) {
    return Container(
      width: MediaQuery.of(context).size.width - 150,
      decoration: BoxDecoration(
        color: Colors.cyan.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(subtitle),
          ],
        ),
      ),
    );
  }

  // list widget
}

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      color: Colors.cyan.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Butuh Bantuan?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text("0812-3456-7890",
                    style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Icon(
            Icons.phone,
            size: 80,
            color: Colors.cyan,
          )
        ],
      ),
    );
  }
}
