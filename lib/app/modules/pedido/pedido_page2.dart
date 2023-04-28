// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

// import 'dart:async';

// import 'package:easy_sidemenu/easy_sidemenu.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:ped/app/app_widget.dart';
// import 'package:ped/app/modules/login/login_page.dart';
// import 'package:ped/app/modules/login/login_store.dart';
// import 'package:ped/app/modules/pedido/loja_store.dart';
// import 'package:ped/app/modules/pedido/pedido_store.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PedidoPage extends StatefulWidget {
//   PedidoPage({super.key, required this.title});

//   final String title;

//   @override
//   State<PedidoPage> createState() => _PedidoPageState();
// }

// class _PedidoPageState extends State<PedidoPage> {
//   var pedidoStore = PedidoStore();
//   var loginStore = LoginStore();
//   var lojaStore = LojaStore();
//   var idPdvDoLogin;

//   getIdPdv() async {
//     final prefs = await SharedPreferences.getInstance();

//     idPdvDoLogin = prefs.getString('idPdv');
//     debugPrint('get$idPdvDoLogin');
//   }

//   deleteIdPdv() async {
//     final prefs = await SharedPreferences.getInstance();

//     await prefs.remove('idPdv');
//     debugPrint('remove$idPdvDoLogin');

//     //if (idPdvDoLogin) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LoginPage(title: 'Login'),
//       ),
//     );
//   }

//   pedidoCall() async {
//     getIdPdv();

//     await pedidoStore.getPedidos(idPdvDoLogin, context);
//   }

//   verificaLojaOnlineCall(String idPdv) async {
//     await lojaStore.verificaLojaOnlineGetApi(idPdv);
//   }

//   ligaDesligaLojaCall(String idPdv, String isActive) async {
//     var x = await lojaStore.ligaDesligaLojaGetApi(idPdv, isActive);
//     return x;
//   }

//   PageController page = PageController();
//   //SideMenuController menu = SideMenuController();

//   @override
//   Widget build(BuildContext context) {
//     bool ligaDesligaLoja = false;
//     bool ligaDesligaChamadaDePedido = false;
//     var corBotao = Colors.red;
//     debugPrint('inicial$idPdvDoLogin');

//     pedidoCall();
//     verificaLojaOnlineCall('0');
//     ligaDesligaLojaCall('0', 'N');

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(widget.title),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: FloatingActionButton(
//               heroTag: 'btnX',
//               onPressed: () {
//                 ligaDesligaChamadaDePedido = true;
//                 deleteIdPdv();
//               },
//               backgroundColor: Colors.amber,
//               elevation: 0,
//               child: Icon(Icons.logout),
//             ),
//           ),
//         ],
//       ),
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SideMenu(
//             items: items,
//             controller: page,
//             footer: const Text("Guia"),
//             onDisplayModeChanged: (mode) {},
//             style: SideMenuStyle(
//               backgroundColor: Colors.black87,
//               selectedColor: Colors.amber,
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               children: [
//                 Column(
//                   children: [
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Observer(builder: (_) {
//                       return Container(
//                         width: MediaQuery.of(this.context).size.width - 330,
//                         height: 150,
//                         color: Colors.amber,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(lojaStore.lojaOpenClose.toString()),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             FloatingActionButton(
//                               heroTag: 'btn',
//                               onPressed: () {
//                                 int z = 0;
//                                 if (ligaDesligaLoja == false) {
//                                   verificaLojaOnlineCall(idPdvDoLogin);
//                                   ligaDesligaLojaCall(idPdvDoLogin, 'S');
//                                   corBotao = Colors.green;
//                                   Timer.periodic(
//                                     Duration(seconds: 1),
//                                     (timer) {
//                                       if (ligaDesligaChamadaDePedido == false) {
//                                         pedidoCall();

//                                         z = z + 1;
//                                         debugPrint('$z');
//                                       } else {
//                                         timer.cancel();
//                                         verificaLojaOnlineCall('0');
//                                         ligaDesligaLojaCall('0', 'N');
//                                         ligaDesligaChamadaDePedido = false;
//                                         corBotao = Colors.red;
//                                       }
//                                     },
//                                   );
//                                   ligaDesligaLoja = true;
//                                 } else {
//                                   ligaDesligaChamadaDePedido = true;
//                                   ligaDesligaLoja = false;
//                                 }
//                               },
//                               backgroundColor: corBotao,
//                               child: Icon(Icons.power_settings_new),
//                             ),
//                           ],
//                         ),
//                       );
//                     }),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         width: MediaQuery.of(context).size.width - 330,
//                         height: 50,
//                         color: Colors.amber,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Codigo'),
//                               Text('Cliente'),
//                               Text('Status'),
//                               Text('Data'),
//                               Text('Valor')
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Observer(
//                       builder: (_) {
//                         return Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: ListView.separated(
//                             shrinkWrap: true,
//                             itemCount: pedidoStore.pedidoList1.length,
//                             itemBuilder: (_, var index) {
//                               return Container(
//                                 width: MediaQuery.of(context).size.width - 330,
//                                 height: 150,
//                                 color: Colors.white24,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     label(
//                                         "",
//                                         (pedidoStore.pedidoList1[index].codigo)
//                                             .toString()),
//                                     label(
//                                         "",
//                                         (pedidoStore.pedidoList1[index].cliente)
//                                             .toString()),
//                                     Column(
//                                       children: [
//                                         label(
//                                             "Cancelado por: ",
//                                             (pedidoStore.pedidoList1[index]
//                                                     .status?.canceladoPor)
//                                                 .toString()),
//                                         label(
//                                             "OBS: ",
//                                             (pedidoStore.pedidoList1[index]
//                                                     .status?.obs)
//                                                 .toString()),
//                                         label(
//                                             "Pedido feito em:",
//                                             (pedidoStore.pedidoList1[index]
//                                                     .status?.dataPedido)
//                                                 .toString()),
//                                         label(
//                                             "Pedido cancelado em: ",
//                                             (pedidoStore.pedidoList1[index]
//                                                     .status?.dataCancelado)
//                                                 .toString()),
//                                       ],
//                                     ),
//                                     label(
//                                         "",
//                                         (pedidoStore.pedidoList1[index].data)
//                                             .toString()),
//                                     label(
//                                         "",
//                                         (pedidoStore.pedidoList1[index].valor)
//                                             .toString()),
//                                     FloatingActionButton(
//                                       heroTag: 'btn$index',
//                                       elevation: 10,
//                                       focusColor: Colors.amber,
//                                       onPressed: () => {},
//                                       child: const Icon(Icons.visibility),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                             separatorBuilder:
//                                 (BuildContext context, int index) =>
//                                     const Divider(),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget label(String label, String value) => Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: <Widget>[
//           //ignore: unnecessary_string_interpolations
//           Text("$label"),
//           Text(value),
//         ],
//       ),
//     );
