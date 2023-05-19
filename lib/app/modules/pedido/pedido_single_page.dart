// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ped/app/modules/pedido/loja_store.dart';
import 'package:ped/app/modules/pedido/pedido_page.dart';
import 'package:ped/app/modules/pedido/pedido_single_store.dart';
import 'package:ped/app/modules/pedido/pedido_store.dart';
import 'package:ped/model/pedido_single_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PedidoSinglePage extends StatefulWidget {
  const PedidoSinglePage({super.key, required this.title, required this.uuid});

  final String title;
  final String uuid;

  @override
  State<PedidoSinglePage> createState() => _PedidoSinglePageState();
}

class _PedidoSinglePageState extends State<PedidoSinglePage> {
  var pedidoSingleStore = PedidoSingleStore();
  var pedidoSingleModel = PedidoSingleModel();
  var pedidoStore = PedidoStore();
  var lojaStore = LojaStore();
  var pedPage = PedidoPage(title: '');

  String? token = '';
  int timerTest = 0;

  var perPage = 1;

  var corBotao = Colors.red;

  bool ligaDesligaLoja = false;
  bool ligaDesligaChamadaDePedido = false;

  getToken() async {
    final prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token');
    // debugPrint('get$token');
  }

  motoqueiroCall(token, uuid) async {

    pedidoSingleModel.setVisibilityCallMotoqueiroButton(false);
    pedidoSingleModel.setVisibilityCallMotoqueiroMessage(true);

    await getToken();

    await pedidoSingleStore.callMotoqueiro(token, uuid, context);
  }

  pedidoSingleCall(uuid) async {
    await getToken();

    await pedidoSingleModel.getPedidoByUuid(token, uuid);
  }

  ligaDesligaLojaCall(bool openClose) async {
    await getToken();

    await lojaStore.ligaDesligaLojaGetApi(token, openClose);
  }

  pedidoCall() async {
    await getToken();

    await pedidoStore.getPedidos(token, context, perPage);
  }

  @override
  Widget build(BuildContext context) {
    pedidoSingleCall(widget.uuid);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 2.5,
                      ),
                      Observer(builder: (_) {
                        return Container(
                          margin: EdgeInsets.all(2.5),
                          width: MediaQuery.of(this.context).size.width,
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
                                        if (ligaDesligaChamadaDePedido ==
                                            false) {
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
                      }),
                    ],
                  ),
                  Observer(builder: (_) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'VISUALIZAR PEDIDO',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.white70,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'PEDIDO - ${pedidoSingleModel.situation}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          '#${pedidoSingleModel.codigo}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Visibility(
                                        visible: pedidoSingleModel
                                            .visibilityCallMotoqueiroButton,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // pedidoSingleModel.setVisibilityCallMotoqueiro(false);
                                            motoqueiroCall(token, widget.uuid);
                                          },
                                          child: Text('Solicitar Motoqueiro'),
                                        ),
                                      ),
                                      Visibility( 
                                        visible: pedidoSingleModel
                                            .visibilityCallMotoqueiroMessage,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                          
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Entrega solicitada'),
                                          ),
                                        ),
                                      ),
                                    
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      height: 1,
                                      width: MediaQuery.of(context).size.width,
                                      child: Container(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  text:
                                                      '${pedidoSingleModel.nameCompany}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                  '${pedidoSingleModel.addressCompany}, ${pedidoSingleModel.numberCompany}'),
                                              Text(
                                                  '${pedidoSingleModel.neighborhoodCompany},'),
                                              Text(
                                                  '${pedidoSingleModel.cityCompany} - ${pedidoSingleModel.cepCompany}'),
                                              SizedBox(height: 10),
                                              Text(
                                                'Telefones',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 200,
                                                height: 100,
                                                child: Expanded(
                                                  child: ListView.builder(
                                                    itemCount: pedidoSingleModel
                                                        .phoneCompany.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(pedidoSingleModel
                                                              .phoneCompany[
                                                                  index]!
                                                              .phone
                                                              .toString()),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  text:
                                                      '${pedidoSingleModel.nameCliente}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                  '${pedidoSingleModel.addressClient}, ${pedidoSingleModel.numberClient}'),
                                              Text(
                                                  '${pedidoSingleModel.neighborhoodClient}'),
                                              Text(
                                                  '${pedidoSingleModel.cityClient} - ${pedidoSingleModel.stateClient} - ${pedidoSingleModel.cepClient}'),
                                              Text(
                                                  '${pedidoSingleModel.complementClient}'),
                                              Text(
                                                  '${pedidoSingleModel.reference}'),
                                              SizedBox(height: 10),
                                              Text(
                                                'CPF na nota: ${pedidoSingleModel.cpfNota}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                '${pedidoSingleModel.phoneClient}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 15),
                                              Text(
                                                'Pedido feito em:',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.calendar_month),
                                                  Text(
                                                      '${pedidoSingleModel.dateOrder}'),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Observação da entrega:',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text('${pedidoSingleModel.obs}')
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                      child: DataTable(
                                        columns: [
                                          DataColumn(label: Text('Qtde')),
                                          DataColumn(label: Text('Produto')),
                                          DataColumn(label: Text('Preço unit.')),
                                          DataColumn(label: Text('total')),
                                        ],
                                        rows: List<DataRow>.generate(
                                          pedidoSingleModel.orderProducts.length,
                                          (index) => DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text(
                                                  '${pedidoSingleModel.orderProducts[index]?.quantity}')),
                                              DataCell(SizedBox(
                                                  width: 300,
                                                  child: Text(
                                                      '${pedidoSingleModel.orderProducts[index]?.productName}'))),
                                              DataCell(SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                      'R\$${pedidoSingleModel.orderProducts[index]?.unitPrice.toStringAsFixed(2)}'))),
                                              DataCell(Text(
                                                  'R\$${pedidoSingleModel.orderProducts[index]?.finalPrice}')),
                                            ],
                                          ),
                                        ),
                                        columnSpacing:
                                            (MediaQuery.of(context).size.width -
                                                    350) /
                                                4,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 70,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                                'Subtotal: R\$${pedidoSingleModel.subTotal?.toStringAsFixed(2)}'),
                                            Text(
                                                'Taxa de entrega: R\$${pedidoSingleModel.deliveryFee?.toStringAsFixed(2)}'),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            SizedBox(
                                              height: 1,
                                              width: 170,
                                              child: Container(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Total: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    'R\$${pedidoSingleModel.orderTotal}')
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                'Forma de pagamento: ${pedidoSingleModel.methodPaymentName}(${pedidoSingleModel.methodPaymentType})')
                                          ],
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          )
                        ],
                      ),
                    );
                  })
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
