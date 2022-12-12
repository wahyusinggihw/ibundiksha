import 'package:flutter/material.dart';
import 'package:ibundiksha/services/list_users_service.dart';
import 'package:ibundiksha/models/list_users_model.dart';
// import 'package:ibundiksha/widgets/menu_home.dart';

class SetoranScreen extends StatefulWidget {
  const SetoranScreen({Key? key}) : super(key: key);

  @override
  State<SetoranScreen> createState() => _SetoranScreenState();
}

class _SetoranScreenState extends State<SetoranScreen> {
  List<ListUsersModel> _listUser = [];

  //2. buat fungsi get data user
  getUsers() async {
    ListUsersService _service = ListUsersService();
    await _service.getDataUsers().then((value) {
      setState(() {
        _listUser = value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    // String active = "Setoran";
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
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _listUser.length,
                  itemBuilder: (context, index) {
                    ListUsersModel data = _listUser[index];
                    return ListTile(
                      title: Text("${data.firstName!} ${data.lastName!}"),
                      subtitle: Text(data.email!),
                      leading: Image.network(data.avatar!),
                      onTap: () => print(data.firstName),
                    );
                  },
                ),
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
