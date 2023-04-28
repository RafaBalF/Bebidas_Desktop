//ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:ped/model/pedidos_model.dart';

part 'pedido_store.g.dart';

class PedidoStore = _PedidoStoreBase with _$PedidoStore;

abstract class _PedidoStoreBase with Store {
  final play = AudioPlayer();

  @observable
  late ObservableList pedidoList1 = [].asObservable();
  @action
  addTodosPedido1(PedidosModel ped) {
    pedidoList1.add(ped);
  }

  @action
  addNovoPedido(PedidosModel ped, context) {
    pedidoList1.add(ped);
    showDialog(
      context: context,
      builder: (_) {
        play.play(AssetSource("Mud_Lonely_This_Christmas.mp3"));
        return AlertDialog(
          title: Text('Aviso'),
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

  @observable
  late ObservableList pedidoList2 = [].asObservable();
  @action
  addTodosPedido2(PedidosModel ped) {
    pedidoList2.add(ped);
  }

  // @override
  // DataRow getRow(int index) {
  //   return DataRow.byIndex(cells: [
  //     DataCell(Text(ped[index].codigo.toString())),
  //     DataCell(Text(ped[index].cliente.toString())),
  //     //DataCell(Text(pedidoList1[index].status.toString())),
  //     DataCell(Text(ped[index].data.toString())),
  //     DataCell(Text(ped[index].valor.toString())),
  //   ]);
  // }

  // //final dispose = reaction((_) {greeting.value}, (msg) => print(msg));

  // @override
  // bool get isRowCountApproximate => false;
  // @override
  // int get rowCount => pedidoList1.length;
  // @override
  // int get selectedRowCount => 0;

  Future<ObservableList> getPedidos(String? token, context, int page) async {
    var headers = {'Authorization': 'Bearer $token'};

    var url = Uri.parse('http://127.0.0.1:8000/api/orders?page=$page');
    var request = http.MultipartRequest('GET', url);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var listaResponse = jsonDecode(await response.stream.bytesToString());

    var x = listaResponse['orders']['data'][0];

    if (response.statusCode == 200) {
      for(int i = 0; i <= 14; i++) {
        PedidosModel p = PedidosModel.fromJson(listaResponse['orders']['data'][i]);
        addTodosPedido1(p);
      }

      // for (var pedido in listaResponse['orders']['data'][0]) {
      //   PedidosModel p = PedidosModel.fromJson(pedido);
      //   addTodosPedido1(p);
      // }

      return pedidoList1;
    }

    for (var pedido in listaResponse['pedido']) {
      PedidosModel p = PedidosModel.fromJson(pedido);
      addTodosPedido1(p);
    }

    // if (pedidoList1.isEmpty && pedidoList2.isEmpty) {
    //   for (var pedido in listaResponse['pedido']) {
    //     PedidosModel p = PedidosModel.fromJson(pedido);
    //     addTodosPedido1(p);
    //   }
    //   //ped = pedidoList1;
    //   for (var pedido in listaResponse['pedido']) {
    //     PedidosModel p = PedidosModel.fromJson(pedido);
    //     addTodosPedido2(p);
    //   }
    // } else {
    //   pedidoList2.removeRange(0, pedidoList2.length);
    //   for (var pedido in listaResponse['pedido']) {
    //     PedidosModel p = PedidosModel.fromJson(pedido);
    //     addTodosPedido2(p);
    //   }
    // }
    // if (pedidoList1.length != pedidoList2.length) {
    //   pedidoList1.removeRange(0, pedidoList1.length);
    //   for (var pedido in listaResponse['pedido']) {
    //     PedidosModel p = PedidosModel.fromJson(pedido);
    //     addNovoPedido(p, context);
    //   }
    // }

    return pedidoList1;
  }
}



// class DadosFonteDaTabela extends DataTableSource {
//   final pedidoStore = PedidoStore();
//   List ped = [];

//   @override
//   DataRow getRow(int index) {
//     ped = pedidoStore.pedidoList1;
//     return DataRow.byIndex(cells: [
//       DataCell(Text(ped[index].codigo.toString())),
//       DataCell(Text(ped[index].cliente.toString())),
//       //DataCell(Text(ped[index].status.toString())),
//       DataCell(Text(ped[index].data.toString())),
//       DataCell(Text(ped[index].valor.toString())),
//     ]);
//   }

//   @override
//   bool get isRowCountApproximate => false;
//   @override
//   int get rowCount => ped.length;
//   @override
//   int get selectedRowCount => 0;
// }
