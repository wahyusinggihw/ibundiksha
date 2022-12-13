import 'package:flutter/material.dart';
import 'package:ibundiksha/services/list_users_service.dart';
import 'package:ibundiksha/models/list_users_model.dart';
import 'package:ibundiksha/services/transaksi_service.dart';
// import 'package:ibundiksha/widgets/menu_home.dart';

class TransaksiDetailScreen extends StatefulWidget {
  const TransaksiDetailScreen({Key? key}) : super(key: key);

  @override
  State<TransaksiDetailScreen> createState() => _TransaksiDetailScreenState();
}

class _TransaksiDetailScreenState extends State<TransaksiDetailScreen> {
  List<ListUsersModel> _listUser = [];
  TextEditingController _saldoController = TextEditingController();
  final _transaksi = Transaksi();

  //2. buat fungsi get data user

  @override
  Widget build(BuildContext context) {
    // String active = "Transaksi";
    // String activeScreen = MenuHome.active;

    dynamic userId = ModalRoute.of(context)!.settings.arguments;

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
          child: Column(
            children: [
              const Text("Masukkan saldo"),
              Container(
                // height: 60,
                child: TextFormField(
                  controller: _saldoController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Saldo harus diisi";
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // print(userId);
                  _transaksi.transferService(
                      userId: int.parse(userId),
                      jumlahSetoran: int.parse(_saldoController.text));

                  // Navigator.pushNamed(context, '/add');
                },
                child: const Text("Tambah"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
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
