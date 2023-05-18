//ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_conditional_assignment, unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:ped/api.dart';
import 'package:ped/app/modules/pedido/pedido_single_page.dart';
import 'package:ped/model/paginator_model.dart';
import 'package:ped/model/pedidos_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pedido_store.g.dart';

class PedidoStore = _PedidoStoreBase with _$PedidoStore;

abstract class _PedidoStoreBase with Store {
  final play = AudioPlayer();
  final paginator = PaginatorModel();

  int? total;

  @observable
  late ObservableList pedidoList1 = [].asObservable();
  @action
  addTodosPedido1(PedidosModel ped) {
    pedidoList1.add(ped);
  }

  @observable
  late int? pageTotal = 1;

  @action
  setPageTotal(int? value) => pageTotal = value;

  Future<dynamic> getPedidos(String? token, context, int page) async {
    var headers = {'Authorization': 'Bearer $token'};

    var url = Uri.parse('$API_URL/orders?page=$page');
    var request = http.MultipartRequest('GET', url);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var listaResponse = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      if (pedidoList1.isEmpty) {
        for (var pedido in listaResponse['orders']['data']) {
          PedidosModel p = PedidosModel.fromJson(pedido);

          getActionButtons(p);

          addTodosPedido1(p);
          setPageTotal(listaResponse['orders']['last_page']);
        }
      } else if (pedidoList1.isNotEmpty) {
        pedidoList1.removeRange(0, pedidoList1.length);
        for (var pedido in listaResponse['orders']['data']) {
          PedidosModel p = PedidosModel.fromJson(pedido);

          getActionButtons(p);

          addTodosPedido1(p);
          setPageTotal(listaResponse['orders']['last_page']);
        }
      }

      if (total == null) {
        total = listaResponse['orders']['total'];
      } else if (total != listaResponse['orders']['total']) {
        total = listaResponse['orders']['total'];
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            play.play(AssetSource("Mud_Lonely_This_Christmas.mp3"));
            return AlertDialog(
              title: Text('Obaa! Novo pedido'),
              content: Text('Você tem um novo pedido'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    play.stop();
                    Navigator.pop(context);
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );
      }

      PaginatorModel pag = PaginatorModel.fromJson(listaResponse['orders']);

      paginator.setTotalPages(pag.totalPages);
      paginator.setCurrentPage(pag.currentPage);
      return listaResponse;
    }

    return listaResponse;
  }

  updatePedido(String? token, String situation, String uuid) async {
    var headers = {'Authorization': 'Bearer $token'};

    var request = http.MultipartRequest(
        'POST', Uri.parse('$API_URL/orders/update/$uuid/$situation'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    jsonDecode(await response.stream.bytesToString());

    debugPrint('ping update');

    // if(response.statusCode == 200) {
    //   debugPrint('teste $data');
    // }
  }

  getActionButtons(p) {
    if (p.situation == 'W') {
      p.botoes = botao(
          Colors.green,
          Icon(Icons.thumb_up_rounded),
          'Notificar que o pedido foi aceito.',
          true,
          true,
          context,
          p.uuid,
          'accept');
    } else if (p.situation == 'R') {
      p.botoes = botao(
          Colors.green,
          Icon(Icons.thumb_up_rounded),
          'Notificar que o pedido foi aceito.',
          false,
          false,
          context,
          p.uuid,
          null);
    } else if (p.situation == 'A') {
      p.botoes = botao(
          Colors.blue,
          Icon(Icons.delivery_dining),
          'Notificar que o pedido saiu para entrega',
          true,
          false,
          context,
          p.uuid,
          'delivery');
    } else if (p.situation == 'D') {
      p.botoes = botao(
          Colors.green,
          Icon(Icons.check),
          'Notificar que o pedido foi entregue',
          true,
          false,
          context,
          p.uuid,
          'finish');
    } else if (p.situation == 'F') {
      p.botoes = botao(
          Colors.green,
          Icon(Icons.check),
          'Notificar que o pedido foi entregue',
          false,
          false,
          context,
          p.uuid,
          null);
    } else {
      p.botoes = botao(
          Colors.green,
          Icon(Icons.check),
          'Notificar que o pedido foi entregue',
          false,
          false,
          context,
          p.uuid,
          null);
    }
  }
}

Row botao(corBotaoAccept, iconBotaoAccept, dicaBotaoAccept,
    visibilityBotaoAccept, visibilityBotaoReject, context, uuid, action) {
  var pedidoStore = PedidoStore();
  String? token = '';

  getToken() async {
    final prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token');
    // debugPrint('get$token');
  }

  updatePedidoAccept(String uuid, action) async {
    await getToken();

    await pedidoStore.updatePedido(token, action, uuid);
  }

  updatePedidoReject(String uuid) async {
    await getToken();
    await pedidoStore.updatePedido(token, 'reject', uuid);
  }

  return Row(
    children: [
      Row(
        children: [
          Visibility(
            visible: visibilityBotaoAccept,
            child: ElevatedButton(
              onPressed: () {
                debugPrint('ping botao');
                updatePedidoAccept(uuid, action);
              },
              child: iconBotaoAccept,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: corBotaoAccept, // <-- Button color
                foregroundColor: Colors.white, // <-- Splash color
              ),
            ),
          ),
          SizedBox(
            width: 2,
          ),
          Visibility(
            visible: visibilityBotaoReject,
            child: ElevatedButton(
              onPressed: () => updatePedidoReject(uuid),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.red, // <-- Button color
                foregroundColor: Colors.white, // <-- Splash color
              ),
              child: Icon(Icons.cancel_rounded),
            ),
          ),
          SizedBox(
            width: 2,
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => PedidoSinglePage(
          //           title: 'Pedidos',
          //           uuid: uuid,
          //         ),
          //       ),
          //     );
          //   },
          //   style: ElevatedButton.styleFrom(
          //     shape: CircleBorder(),
          //     padding: EdgeInsets.all(20),
          //     backgroundColor: Colors.blue, // <-- Button color
          //     foregroundColor: Colors.white, // <-- Splash color
          //   ),
          //   child: Icon(Icons.visibility_outlined),
          // ),
        ],
      )
    ],
  );
}

class Paginate {
  Paginate({
    required this.currentPage,
    required this.lastPage,
  });
  late final int currentPage;
  late final int lastPage;

  Paginate.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = currentPage;
    _data['last_page'] = lastPage;
    return _data;
  }
}
