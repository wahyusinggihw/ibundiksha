import 'package:flutter/material.dart';
import 'package:ibundiksha/router/route_list.dart';
import 'package:ibundiksha/services/list_users_service.dart';
import 'package:ibundiksha/models/list_users_model.dart';
// import 'package:ibundiksha/widgets/menu_home.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  List<ListUsersModel> _listUser = [];

  //2. buat fungsi get data user
  getUsers() async {
    ListUsersService _service = ListUsersService();

    await _service.getDataUsers().then((value) {
      if (mounted) {
        setState(() {
          _listUser = value!;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

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
        title: const Text("Transfer"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _listUser.length,
                  itemBuilder: (context, index) {
                    ListUsersModel data = _listUser[index];
                    return ListTile(
                      title: Text(data.nama!),
                      subtitle: Text(data.username!),
                      onTap: () {
                        // print(data.userId!);
                        Navigator.pushNamed(context, routeTransferDetailScreen,
                            arguments: {
                              'userId': data.userId,
                              'nama': data.nama,
                              'username': data.username,
                            });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/add');
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

Widget cardlist(
    String title, String subtitle, Color color, String nilai, Color bgColor) {
  return Card(
    color: bgColor,
    child: ListTile(
      title: Text(title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text(subtitle),
      trailing: Container(
        height: 50,
        width: 50,
        color: color,
        child: Center(
          child: Text(nilai,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    ),
  );
}
