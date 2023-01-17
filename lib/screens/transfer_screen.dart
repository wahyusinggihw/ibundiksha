import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ibundiksha/router/route_list.dart';
import 'package:ibundiksha/services/list_users_service.dart';
import 'package:ibundiksha/models/list_users_model.dart';
import 'package:ibundiksha/widgets/my_style.dart';
import 'package:ibundiksha/widgets/snackbars.dart';
// import 'package:ibundiksha/widgets/menu_home.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _nomorRekeningController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //2. buat fungsi get data user
  List<ListUsersModel> _listUser = [];

  getUsers() async {
    final ListUsersService service = ListUsersService();
    await service.getDataUsers().then((value) {
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

  bool userExist = false;
  late String nama;
  late String nomorRekening;

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Masukkan nomor rekening tujuan",
                      style: MyStyle().h1Style(),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _nomorRekeningController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.account_balance_wallet),
                        labelText: "Nomor Rekening",
                        hintText: "Masukkan Nomor Rekening",
                      ),
                      validator: (value) => value!.isEmpty
                          ? "Nomor rekening tidak boleh kosong"
                          : null,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    for (var i = 0; i < _listUser.length; i++) {
                      if (_listUser[i].nomorRekening ==
                          _nomorRekeningController.text) {
                        userExist = true;
                        nama = _listUser[i].nama!;
                        nomorRekening = _listUser[i].nomorRekening!;
                        break;
                      } else {
                        userExist = false;
                      }
                    }
                    if (!userExist) {
                      var notExits =
                          errorSnackBar("Nomor rekening tidak ditemukan");
                      ScaffoldMessenger.of(context).showSnackBar(notExits);
                      if (kDebugMode) {
                        print('Nomor rekening tidak ditemukan');
                      }
                    } else {
                      Navigator.pushNamed(context, routeTransferDetailScreen,
                          arguments: {
                            'nomorRekening': _nomorRekeningController.text,
                            'nama': nama,
                          });
                    }
                  }
                },
                child: const Text("Lanjutkan"),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text(subtitle),
      trailing: Container(
        height: 50,
        width: 50,
        color: color,
        child: Center(
          child: Text(nilai,
              style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    ),
  );
}
