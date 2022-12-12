import 'package:flutter/material.dart';
import 'package:ibundiksha/models/current_user_model.dart';
import 'package:ibundiksha/router/route_list.dart';
import 'package:ibundiksha/widgets/list_menu.dart';
import 'package:ibundiksha/widgets/menu_home.dart';
import 'package:ibundiksha/widgets/dialogs.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:ibundiksha/services/shared_preferences.dart';
import 'package:ibundiksha/services/auth_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPrefs sharedPrefs = SharedPrefs();
  String username = '';
  String saldo = '';
  final _auth = Auth();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username = sharedPrefs.getString('username');
    saldo = sharedPrefs.getString('saldo');
  }

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
            visibleWhen: const [
              Condition.largerThan(name: MOBILE),
            ],
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              onPressed: () {},
              child: const Text("Logout"),
            ),
          ),
          IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.logout),
            onPressed: () async {
              var status = await _auth.logoutService();

              print(status.isLoggedIn);
              if (status.isLoggedIn == false) {
                Navigator.pushNamedAndRemoveUntil(
                    context, routeLoginScreen, (route) => false);
              }
              // Dialogs().showAlertDialog(
              //     context, 'Logout', 'Anda yakin ingin logout?', '/login');
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
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      mainWideContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ResponsiveRowColumn(
                            layout: ResponsiveWrapper.of(context)
                                    .isSmallerThan(TABLET)
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
                                      image:
                                          AssetImage('assets/images/user.jpg'),
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
                                    bioBox(context, 'Nama', username),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    bioBox(context, 'Saldo', saldo),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: mainWideContainer(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ResponsiveRowColumn(
                          layout: ResponsiveWrapper.of(context)
                                  .isSmallerThan(TABLET)
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
                                  bioBox(context, 'Nama', username),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  bioBox(context, 'Saldo', saldo),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),

            // P
            const SizedBox(
              height: 20,
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 450) {
                  print("lebih 450");
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: mainWideContainer(
                      // width: 500,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: menus.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: mainContainer(
                      context,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: menus.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Contact()
          ],
        ),
      ),
    );
  }
}
