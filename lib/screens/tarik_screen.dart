// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ibundiksha/services/transaksi_service.dart';
import 'package:ibundiksha/services/shared_preferences.dart';
import 'package:ibundiksha/widgets/bottombar.dart';
import 'package:ibundiksha/widgets/my_style.dart';
import 'package:ibundiksha/widgets/snackbars.dart';
// import 'package:ibundiksha/widgets/menu_home.dart';

class TarikScreen extends StatefulWidget {
  const TarikScreen({Key? key}) : super(key: key);

  @override
  State<TarikScreen> createState() => _TarikScreenState();
}

class _TarikScreenState extends State<TarikScreen> {
  final TextEditingController _saldoController = TextEditingController();
  final _transaksi = Transaksi();
  final _formKey = GlobalKey<FormState>();
  SharedPrefs sharedPrefs = SharedPrefs();
  String saldo = '';
  String currentUserId = '';
  MyStyle myStyle = MyStyle();

  @override
  void initState() {
    super.initState();
    currentUserId = sharedPrefs.getString('userId');
  }

  getSaldo() {
    saldo = sharedPrefs.getString('saldo');
    return saldo;
  }

  @override
  Widget build(BuildContext context) {
    saldo = sharedPrefs.getString('saldo');

    return WillPopScope(
      onWillPop: () async {
        var data = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BottomBar()),
        );
        Navigator.pop(context, data);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          centerTitle: true,
          // automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              var data = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BottomBar()),
              );
              Navigator.pop(context, data);
            },
          ),
          title: const Text("Tarik Tunai"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const SizedBox(height: 20),
                Text("Masukkan nominal", style: MyStyle().h1Style()),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(height: 10),
                    const Text("Rp. "),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _saldoController,
                          decoration: const InputDecoration(
                              // border: OutlineInputBorder(),
                              ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Nominal harus diisi";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width - 20,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (double.parse(saldo) <
                              double.parse(_saldoController.text)) {
                            // snackbar
                            var snackbar =
                                errorSnackBar("Saldo tidak mencukupi");
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } else {
                            var data = await _transaksi.tarikanService(
                                userId: int.parse(currentUserId),
                                jumlahTarikan:
                                    double.parse(_saldoController.text));

                            var saldo = await getSaldo();

                            if (data['status'] == 'success') {
                              // snackbar
                              var snackbar =
                                  successSnackBar("Tarik tunai berhasil");
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
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
                              var snackbar = errorSnackBar("Tarik tunai gagal");
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            }
                          }
                        }
                      },
                      child: const Text("Tarik Tunai"),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
