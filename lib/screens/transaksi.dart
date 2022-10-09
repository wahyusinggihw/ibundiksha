import 'package:flutter/material.dart';
// import 'package:ibundiksha/widgets/menu_home.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({Key? key}) : super(key: key);

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  @override
  Widget build(BuildContext context) {
    // String active = "Transaksi";
    // String activeScreen = MenuHome.active;

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
        title: Text("Transaksi"),
      ),
      body: SafeArea(
          child: Center(
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(
                Icons.account_balance_wallet,
                size: 50,
              ),
              title: Text('Transaksi ke-$index'),
              subtitle: Text('Rp. $index' + '00.000'),
              onTap: () => print("$index"),
            );
          },
        ),
      )),
    );
  }
}
