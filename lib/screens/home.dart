import 'package:flutter/material.dart';
import 'package:ibundiksha/widgets/appbar.dart';
import 'package:ibundiksha/widgets/list_menu.dart';
import 'package:ibundiksha/widgets/menu_home.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ibundiksha/widgets/dialogs.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var menuGrid = MenuHome().menuGrid;
    var bioBox = MenuHome.bioBox;
    var mainContainer = MenuHome.mainContainer;
    var mainWideContainer = MenuHome.mainWideContainer;

    return Scaffold(
      appBar: AppBar(
        title: Text('Koperasi Undiksha'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.cyan,
        actions: [
          ResponsiveVisibility(
            visible: false,
            visibleWhen: [Condition.largerThan(name: MOBILE)],
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              onPressed: () {},
              child: Text("Logout"),
            ),
          ),
          IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.logout),
            onPressed: () {
              Dialogs().showAlertDialog(
                  context, 'Logout', 'Anda yakin ingin logout?', '/login');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: mainWideContainer(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ResponsiveRowColumn(
                    layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                        ? ResponsiveRowColumnType.ROW
                        : ResponsiveRowColumnType.COLUMN,
                    children: [
                      ResponsiveRowColumnItem(
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/user.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      ResponsiveRowColumnItem(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            bioBox('Nama', 'Wahyu Singgih Wicaksono'),
                            const SizedBox(
                              height: 5,
                            ),
                            bioBox('Saldo', 'Rp. 100.000'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: menus.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) {
                Menus menu = menus[index];
                return menuGrid(
                  context,
                  menu.title,
                  menu.icon,
                  menu.routeScreen,
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
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
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text("0812-3456-7890",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold)),
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
            )
          ],
        ),
      ),
    );
  }
}
