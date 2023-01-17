import 'package:flutter/material.dart';

class Receipt extends StatefulWidget {
  const Receipt({Key? key}) : super(key: key);

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: Stack(
          children: [
            Container(
              width: width * 0.9,
              height: width * 0.9,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.white,
                  // borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text("Receipt"),
                  Text("Pembayaran berhasil"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
