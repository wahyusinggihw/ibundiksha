import 'package:flutter/material.dart';
import 'package:ibundiksha/widgets/menu_home.dart';

class NoRouteScreen extends StatelessWidget {
  const NoRouteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String activeScreen = MenuHome.active;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        // automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(activeScreen),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Oops, nampaknya kamu tersesat'),
              TextButton(
                onPressed: () {
                  // print(activeScreen);
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
