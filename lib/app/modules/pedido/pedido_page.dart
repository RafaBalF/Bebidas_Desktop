// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:ped/app/modules/login/login_page.dart';
import 'package:ped/app/modules/login/login_store.dart';
import 'package:ped/app/modules/pedido/loja_store.dart';
import 'package:ped/app/modules/pedido/pedido_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

class PedidoPage extends StatefulWidget {
  PedidoPage({super.key, required this.title});

  final String title;

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  var pedidoStore = PedidoStore();
  var loginStore = LoginStore();
  var lojaStore = LojaStore();
  var idPdvDoLogin;
  var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNjgyNjgzOTg4LCJleHAiOjE2ODMyODM5ODgsIm5iZiI6MTY4MjY4Mzk4OCwianRpIjoiNDlMclBSdTRoWmtTMERSSiIsInN1YiI6MTcwODI1LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.O4eu-cdaENgvfSq7pZjTbcm9glQlBvFdENtduwUP07o';
  var per_page = 1;
  //final DataTableSource dadosPedidos = DadosFonteDaTabela();

  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  getIdPdv() async {
    final prefs = await SharedPreferences.getInstance();

    idPdvDoLogin = prefs.getString('idPdv');
    debugPrint('get$idPdvDoLogin');
  }

  deleteIdPdv() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('idPdv');
    debugPrint('remove$idPdvDoLogin');

    //if (idPdvDoLogin) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(title: 'Login'),
      ),
    );
  }

  pedidoCall() async {
    getIdPdv();

    await pedidoStore.getPedidos(token, context, per_page);

    debugPrint('777');
  }

  verificaLojaOnlineCall(String idPdv) async {
    await lojaStore.verificaLojaOnlineGetApi(idPdv);
  }

  ligaDesligaLojaCall(String idPdv, String isActive) async {
    var x = await lojaStore.ligaDesligaLojaGetApi(idPdv, isActive);
    return x;
  }

  PageController page = PageController();
  //SideMenuController menu = SideMenuController();

  @override
  Widget build(BuildContext context) {
    bool ligaDesligaLoja = false;
    bool ligaDesligaChamadaDePedido = false;
    var corBotao = Colors.red;
    int selectedPageNumber = 1;

    pedidoCall();
    verificaLojaOnlineCall('0');
    ligaDesligaLojaCall('0', 'N');

    //DesktopWindow.getFullScreen();
    //DesktopWindow.setFullScreen(fullscream);
    //testWindowFunctions();

    //DataTableSource dadosPedidos = DadosFonteDaTabela();
    //print(dadosPedidos);

    // paginaTabela() {
    //   Timer(Duration(seconds: 5), () {
    //     final DataTableSource dadosPedidos = DadosFonteDaTabela();
    //     dadosPedidos.getPedidos

    //     PaginatedDataTable(
    //       source: dadosPedidos,
    //       header: const Text('Pedidos'),
    //       columns: const [
    //         DataColumn(label: Text('Codigo')),
    //         DataColumn(label: Text('Cliente')),
    //         //DataColumn(label: Text('Status')),
    //         DataColumn(label: Text('Data')),
    //         DataColumn(label: Text('Valor'))
    //       ],
    //       columnSpacing: 100,
    //       horizontalMargin: 10,
    //       rowsPerPage: 8,
    //       showCheckboxColumn: false,
    //     );
    //     // dadosPedidos = dadosPedidos2;
    //     // print(dadosPedidos);
    //     // dadosPedidos.notifyListeners();
    //   });
    // }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: 'btnX',
              onPressed: () {
                ligaDesligaChamadaDePedido = true;
                deleteIdPdv();
              },
              backgroundColor: Colors.amber,
              elevation: 0,
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // SideMenu(
          //   items: items,
          //   controller: page,
          //   footer: const Text("Guia"),
          //   onDisplayModeChanged: (mode) {},
          //   style: SideMenuStyle(
          //     backgroundColor: Colors.black87,
          //     selectedColor: Colors.amber,
          //   ),
          // ),
          Expanded(
            child: PageView(
              // controller: page,
              children: [
                SizedBox(
                  width: 500,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Observer(builder: (_) {
                            return Container(
                              width:
                                  MediaQuery.of(this.context).size.width - 5,
                              height: 150,
                              color: Colors.amber,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(lojaStore.lojaOpenClose.toString()),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  FloatingActionButton(
                                    heroTag: 'btn',
                                    onPressed: () {
                                      int z = 0;
                                      if (ligaDesligaLoja == false) {
                                        verificaLojaOnlineCall(idPdvDoLogin);
                                        ligaDesligaLojaCall(idPdvDoLogin, 'S');
                                        corBotao = Colors.green;
                                        Timer.periodic(
                                          Duration(seconds: 1),
                                          (timer) {
                                            if (ligaDesligaChamadaDePedido ==
                                                false) {
                                              pedidoCall();

                                              z = z + 1;
                                              debugPrint('$z');
                                            } else {
                                              timer.cancel();
                                              verificaLojaOnlineCall('0');
                                              ligaDesligaLojaCall('0', 'N');
                                              ligaDesligaChamadaDePedido =
                                                  false;
                                              corBotao = Colors.red;
                                            }
                                          },
                                        );
                                        ligaDesligaLoja = true;
                                      } else {
                                        ligaDesligaChamadaDePedido = true;
                                        ligaDesligaLoja = false;
                                      }
                                    },
                                    backgroundColor: corBotao,
                                    child: Icon(Icons.power_settings_new),
                                  ),
                                ],
                              ),
                            );
                          }),
                          SizedBox(
                            height: 30,
                          ),
                          Observer(builder: (_) {
                            return DataTable(
                              columns: const [
                                DataColumn(label: Text('Codigo')),
                                DataColumn(label: Text('Cliente')),
                                DataColumn(label: Text('Status')),
                                DataColumn(label: Text('Data')),
                                DataColumn(label: Text('Valor'))
                              ],
                              rows: List<DataRow>.generate(
                                pedidoStore.pedidoList1.length,
                                (index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(pedidoStore
                                        .pedidoList1[index].codigo
                                        .toString())),
                                    DataCell(Text(pedidoStore
                                        .pedidoList1[index].cliente
                                        .toString())),
                                    DataCell(Text(
                                        (pedidoStore.pedidoList1[index].status)
                                            .toString())),
                                    DataCell(Text(pedidoStore
                                        .pedidoList1[index].data
                                        .toString())),
                                    DataCell(Text(pedidoStore
                                        .pedidoList1[index].valor
                                        .toString())),
                                  ],
                                ),
                              ),
                              columnSpacing:
                                  (MediaQuery.of(context).size.width - 700) / 5,
                              dataRowHeight: 150,
                              horizontalMargin: 10,
                              showCheckboxColumn: false,
                            );
                          }),
                          // NumberPaginator(
                          //   numberPages: ,
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget label(String label, String value) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          //ignore: unnecessary_string_interpolations
          Text("$label"),
          Text(value),
        ],
      ),
    );
