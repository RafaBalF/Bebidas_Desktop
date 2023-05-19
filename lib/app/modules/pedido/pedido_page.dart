// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:ped/app/modules/login/login_page.dart';
import 'package:ped/app/modules/login/login_store.dart';
import 'package:ped/app/modules/pedido/loja_store.dart';
import 'package:ped/app/modules/pedido/pedido_single_page.dart';
import 'package:ped/app/modules/pedido/pedido_store.dart';
import 'package:ped/model/paginator_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PedidoPage extends StatefulWidget {
  PedidoPage({super.key, required this.title});

  final String title;

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  var pedidoStore = PedidoStore();
  var lojaStore = LojaStore();
  var paginator = PaginatorModel();

  String? token = '';
  var perPage = 1;
  int indexText = 1;

  bool ligaDesligaLoja = false;
  bool ligaDesligaChamadaDePedido = false;

  var corBotao = Colors.green;
  var corContainer = Colors.red;

  final NumberPaginatorController _controller = NumberPaginatorController();
  final ScrollController _scrollController = ScrollController();

  int timerTest = 0;

  getToken() async {
    final prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token');
    // debugPrint('get$token');
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('token');
    debugPrint('remove$token');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(title: 'Login'),
      ),
    );
  }

  pedidoCall() async {
    await getToken();

    await pedidoStore.getPedidos(token, context, perPage);
  }

  ligaDesligaLojaCall(bool openClose) async {
    await getToken();

    await lojaStore.ligaDesligaLojaGetApi(token, openClose);
  }

  PageController page = PageController();

  @override
  Widget build(BuildContext context) {
    pedidoCall();

    // Timer.periodic(
    //   Duration(seconds: 10),
    //   (timerx) {
    //     pedidoCall();
    //     timerTest = timerTest + 1;
    //     debugPrint('Timer teeest $timerTest');
    //   },
    // );

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
                logout();
                ligaDesligaLojaCall(false);
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
          Expanded(
            child: PageView(
              children: [
                SizedBox(
                  width: 500,
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Observer(builder: (_) {
                            return Container(
                              width: MediaQuery.of(this.context).size.width - 5,
                              height: 150,
                              color: corContainer,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(lojaStore.lojaOpenCloseMensage
                                      .toString(), style: TextStyle(color: Colors.white, fontSize: 20),),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  FloatingActionButton(
                                    heroTag: 'btn',
                                    onPressed: () {
                                      if (ligaDesligaLoja == false) {
                                        ligaDesligaLojaCall(true);
                                        corBotao = Colors.red;
                                        corContainer = Colors.green;
                                        Timer.periodic(
                                          Duration(seconds: 1),
                                          (timer) {
                                            if (ligaDesligaChamadaDePedido ==
                                                false) {
                                              pedidoCall();

                                              timerTest = timerTest + 1;
                                              debugPrint(
                                                  'Timer teeest $timerTest');
                                            } else {
                                              timer.cancel();
                                              ligaDesligaLojaCall(false);
                                              ligaDesligaChamadaDePedido =
                                                  false;
                                              corBotao = Colors.green;
                                              corContainer = Colors.red;
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
                              columns: [
                                DataColumn(label: Text('Codigo')),
                                DataColumn(label: Text('Cliente')),
                                DataColumn(label: Text('Status')),
                                DataColumn(label: Text('Data')),
                                DataColumn(label: Text('Valor')),
                                DataColumn(label: Text(''))
                              ],
                              rows: List<DataRow>.generate(
                                pedidoStore.pedidoList1.length,
                                (index) => DataRow(
                                  // onLongPress: () {setttere();},
                                  cells: <DataCell>[
                                    DataCell(SizedBox(
                                      width:
                                          ((MediaQuery.of(context).size.width -
                                                  1000) /
                                              6),
                                      child: Text(pedidoStore
                                          .pedidoList1[index].codigo
                                          .toString()),
                                    )),
                                    DataCell(SizedBox(
                                      width:
                                          ((MediaQuery.of(context).size.width -
                                                  700) /
                                              6),
                                      child: Text(pedidoStore
                                          .pedidoList1[index].cliente
                                          .toString()),
                                    )),
                                    DataCell(SizedBox(
                                      width:
                                          ((MediaQuery.of(context).size.width -
                                                  600) /
                                              6),
                                      child: Text((pedidoStore
                                              .pedidoList1[index].status)
                                          .toString()),
                                    )),
                                    DataCell(SizedBox(
                                      width:
                                          ((MediaQuery.of(context).size.width -
                                                  500) /
                                              6),
                                      child: Text(pedidoStore
                                          .pedidoList1[index].data
                                          .toString()),
                                    )),
                                    DataCell(SizedBox(
                                      width:
                                          ((MediaQuery.of(context).size.width -
                                                  900) /
                                              6),
                                      child: Text(pedidoStore
                                          .pedidoList1[index].valor
                                          .toString()),
                                    )),
                                    DataCell(
                                      // onTap: () {setttere();},
                                      SizedBox(
                                        width: ((MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                100) /
                                            6),
                                        child: Row(
                                          children: [
                                            pedidoStore
                                                .pedidoList1[index].botoes,
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PedidoSinglePage(
                                                      title: 'Pedidos',
                                                      uuid: pedidoStore
                                                          .pedidoList1[index]
                                                          .uuid,
                                                    ),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: CircleBorder(),
                                                padding: EdgeInsets.all(20),
                                                backgroundColor: Colors
                                                    .white, // <-- Button color
                                                foregroundColor: Colors.blue,
                                                // <-- Splash color
                                              ),
                                              child: Icon(
                                                  Icons.visibility_outlined),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              columnSpacing: 100,
                              dataRowHeight: 150,
                              horizontalMargin: 10,
                              showCheckboxColumn: false,
                            );
                          }),
                          Observer(builder: (_) {
                            return NumberPaginator(
                              controller: _controller,
                              numberPages: pedidoStore.pageTotal!.toInt(),
                              onPageChange: (int indexPag) {
                                perPage = indexPag + 1;
                                setState(() {
                                  indexText = indexText++;
                                });
                                debugPrint(
                                    'current page in page ${pedidoStore.pageTotal}');
                                pedidoCall();
                                _scrollController.animateTo(
                                  _scrollController.position.minScrollExtent,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastOutSlowIn,
                                );
                              },
                              initialPage: 0,
                            );
                          }),
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

Container controleLoja(context, perPage, lojaStore, ligaDesligaLoja, corBotao, timerTest, ligaDesligaChamadaDePedido) {
  String? token = '';
  var pedidoStore = PedidoStore();
  getToken() async {
    final prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token');
    // debugPrint('get$token');
  }
  
  ligaDesligaLojaCall(bool openClose) async {
    await getToken();

    await lojaStore.ligaDesligaLojaGetApi(token, openClose);
  }
  pedidoCall() async {
    await getToken();

    await pedidoStore.getPedidos(token, context, perPage);
  }
  return Container(
    width: MediaQuery.of(context).size.width - 5,
    height: 150,
    color: Colors.amber,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(lojaStore.lojaOpenCloseMensage.toString()),
        SizedBox(
          width: 10,
        ),
        FloatingActionButton(
          heroTag: 'btn',
          onPressed: () {
            if (ligaDesligaLoja == false) {
              ligaDesligaLojaCall(true);
              corBotao = Colors.green;
              Timer.periodic(
                Duration(seconds: 1),
                (timer) {
                  if (ligaDesligaChamadaDePedido == false) {
                    pedidoCall();

                    timerTest = timerTest + 1;
                    debugPrint('Timer teeest $timerTest');
                  } else {
                    timer.cancel();
                    ligaDesligaLojaCall(false);
                    ligaDesligaChamadaDePedido = false;
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
}
