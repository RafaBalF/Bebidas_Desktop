// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ped/model/pedido_single_model.dart';

class PedidoSingleStore {
  var pedidoUnico = PedidoSingleModel();

  // getPedidoByUuid(String? token, uuid) async {
  //   var headers = {'Authorization': 'Bearer $token'};

  //   var request = http.MultipartRequest(
  //       'GET', Uri.parse('http://127.0.0.1:8000/api/orders/$uuid'));

  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   var data = jsonDecode(await response.stream.bytesToString());

  //   if (response.statusCode == 200) {
  //     PedidoSingleModel ped = PedidoSingleModel.fromJson(data);

  //     ped.setStatus('teste');

  //     pedidoUnico = ped;

  //     return pedidoUnico;
  //   }
  // }

  callMotoqueiro(String? token, uuid, context) async {
    var headers = {'Authorization': 'Bearer $token'};

    var request = http.Request(
        'GET',
        Uri.parse(
            'http://127.0.0.1:8000/api/orderDelivery/callDelivery/$uuid'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Aviso'),
            content: Text('Motoqueiro solicitado com suceso'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    }

    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Aviso'),
          content: Text('Falha ao solicitar motoqueiro'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
