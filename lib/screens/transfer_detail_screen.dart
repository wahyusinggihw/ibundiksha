// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ibundiksha/services/transaksi_service.dart';
import 'package:ibundiksha/services/shared_preferences.dart';
import 'package:ibundiksha/widgets/my_style.dart';
import 'package:ibundiksha/widgets/snackbars.dart';
// import 'package:ibundiksha/widgets/menu_home.dart';

class TransferDetailScreen extends StatefulWidget {
  const TransferDetailScreen({Key? key}) : super(key: key);

  @override
  State<TransferDetailScreen> createState() => _TransferDetailScreenState();
}

class _TransferDetailScreenState extends State<TransferDetailScreen> {
  // List<ListUsersModel> _listUser = [];
  final TextEditingController _jumlahTransferController =
      TextEditingController();
  final _transaksi = Transaksi();
  final _formKey = GlobalKey<FormState>();
  SharedPrefs sharedPrefs = SharedPrefs();
  String saldo = '';
  String currentUserId = '';
  MyStyle myStyle = MyStyle();
  Transaksi transaksi = Transaksi();

  @override
  void initState() {
    super.initState();
    currentUserId = sharedPrefs.getString('userId');
    // _transaksi.currentUserSaldo(userId: int.parse(currentUserId));
  }

  //2. buat fungsi get data user

  @override
  Widget build(BuildContext context) {
    saldo = sharedPrefs.getString('saldo');

    dynamic dataTransaksi = ModalRoute.of(context)!.settings.arguments;

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
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text("Rekening Tujuan", style: MyStyle().h1Style()),
                  ListTile(
                    leading: const Icon(Icons.account_circle, size: 50),
                    title:
                        Text(dataTransaksi['nama'] ?? "Nama tidak ditemukan"),
                    subtitle: Text(dataTransaksi['nomorRekening'] ??
                        "Nomor rekening tidak ditemukan"),
                  ),
                  const SizedBox(height: 20),
                  Text("Nominal transfer", style: MyStyle().h1Style()),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Rp. "),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _jumlahTransferController,
                            decoration: const InputDecoration(
                                // border: OutlineInputBorder(),
                                ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Saldo harus diisi";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text("Saldo anda", style: MyStyle().h1Style()),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Rp. "),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(saldo),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // const Spacer(),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width - 20,
                      child: ElevatedButton(
                        onPressed: () async {
                          //  validator
                          if (_formKey.currentState!.validate()) {
                            if (double.parse(saldo) <
                                double.parse(_jumlahTransferController.text)) {
                              // snackbar
                              var snackbar =
                                  errorSnackBar("Saldo tidak mencukupi");
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            } else {
                              var data = await _transaksi.transferService(
                                nomorRekening: dataTransaksi['nomorRekening'],
                                idPengirim: int.parse(currentUserId),
                                jumlahTransfer:
                                    int.parse(_jumlahTransferController.text),
                              );

                              if (data['status'] == 'success') {
                                // snackbar
                                var snackbar =
                                    successSnackBar("Transfer berhasil");
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                                // setState(() {
                                //   saldo = sharedPrefs.getString('saldo');
                                // });
                                _transaksi
                                    .currentUserSaldo(
                                        userId: int.parse(currentUserId))
                                    .then((value) {
                                  setState(() {
                                    saldo = value[0]['saldo'];
                                  });
                                });
                              } else {
                                // snackbar
                                var snackbar = errorSnackBar("Transfer gagal");
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              }
                            }
                          }
                        },
                        child: const Text("Transfer"),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                ],
              ),
            ),
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
