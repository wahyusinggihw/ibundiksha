import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ibundiksha/router/route_list.dart';

class Menus {
  final title;
  final icon;
  final routeScreen;

  const Menus({this.title, this.icon, this.routeScreen});
}

final List<Menus> menus = _menus
    .map((e) => Menus(
        title: e['title'], icon: e['icon'], routeScreen: e['routeScreen']))
    .toList(growable: false);

// list of single menu
final List<Map<String, Object>> _menus = [
  // {
  //   'title': 'Saldo',
  //   'icon': MdiIcons.wallet,
  //   'routeScreen': routeSaldoScreen,
  // },
  {
    'title': 'Transfer',
    'icon': MdiIcons.bankTransferOut,
    'routeScreen': routeTransferScreen,
  },
  {
    'title': 'Tarik',
    'icon': MdiIcons.undoVariant,
    'routeScreen': routeTarikScreen,
  },
  {
    'title': 'Setoran',
    'icon': MdiIcons.cashFast,
    'routeScreen': routeSetoranScreen,
  },
  // {
  //   'title': 'Pembayaran',
  //   'icon': MdiIcons.creditCardOutline,
  //   'routeScreen': routePembayaranScreen,
  // },
  // {
  //   'title': 'Pinjaman',
  //   'icon': MdiIcons.handCoinOutline,
  //   'routeScreen': noRoute,
  // },
  // {
  //   'title': 'Mutasi',
  //   'icon': MdiIcons.creditCardRefundOutline,
  //   'routeScreen': noRoute,
  // },
];

// // list widget
// List<Menus> menus = [
//   Menus(
//     title: "Home",
//     icon: CupertinoIcons.home,
//     routeScreen: "/home",
//   ),
//   Menus(
//     title: "Profile",
//     icon: CupertinoIcons.person,
//     routeScreen: "/profile",
//   ),
//   Menus(
//     title: "Simpanan",
//     icon: CupertinoIcons.money_dollar_circle,
//     routeScreen: "/simpanan",
//   ),
//   Menus(
//     title: "Pinjaman",
//     icon: CupertinoIcons.money_dollar_circle,
//     routeScreen: "/pinjaman",
//   ),
//   Menus(
//     title: "Angsuran",
//     icon: CupertinoIcons.money_dollar_circle,
//     routeScreen: "/angsuran",
//   ),
//   Menus(
//     title: "Pengaturan",
//     icon: CupertinoIcons.settings,
//     routeScreen: "/pengaturan",
//   )
// ];
