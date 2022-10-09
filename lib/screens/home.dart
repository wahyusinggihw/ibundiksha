import 'package:flutter/material.dart';
import 'package:ibundiksha/widgets/appbar.dart';
import 'package:ibundiksha/widgets/menu_home.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ibundiksha/widgets/dialogs.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var menuGrid = MenuHome().menuGrid;
    var bioBox = MenuHome.bioBox;
    var mainContainer = MenuHome.mainContainer;

    return Scaffold(
      appBar: AppBar(
        title: Text('Koperasi Undiksha'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.cyan,
        actions: [
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
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            mainContainer(
              context,
              width: MediaQuery.of(context).size.width - 20,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
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
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bioBox(context, 'Nama', 'Wahyu Singgih Wicaksono'),
                        const SizedBox(
                          height: 5,
                        ),
                        bioBox(context, 'Saldo', 'Rp. 100.000'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            mainContainer(
              context,
              width: MediaQuery.of(context).size.width - 20,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      menuGrid(context, 'Saldo', MdiIcons.wallet, '/saldo'),
                      menuGrid(context, 'Transfer', MdiIcons.bankTransferOut,
                          '/transaksi'),
                      menuGrid(
                          context, 'Deposit', MdiIcons.cashPlus, '/deposit'),
                    ],
                  ),
                  TableRow(
                    children: [
                      menuGrid(context, 'Pembayaran',
                          MdiIcons.creditCardOutline, '/pembayaran'),
                      menuGrid(context, 'Pinjaman', MdiIcons.handCoinOutline,
                          '/pinjaman'),
                      menuGrid(context, 'Mutasi',
                          MdiIcons.creditCardRefundOutline, '/mutasi'),
                    ],
                  ),
                ],
              ),
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
