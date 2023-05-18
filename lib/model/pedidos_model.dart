// ignore_for_file: library_private_types_in_public_api, unused_element

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:ped/model/status_model.dart';

part 'pedidos_model.g.dart';

class PedidosModel = _PedidosModelBase with _$PedidosModel;

abstract class _PedidosModelBase with Store {
  @observable
  late int? codigo;
  @observable
  late String? cliente;
  @observable
  late String? status;
  @observable
  late String? data;
  @observable
  late String? valor;
  @observable
  late String? uuid;
  @observable
  late String? situation;

  @observable
  Row? botoes;

  @action
  setCodigo(int? value) => codigo = value;
  @action
  setCliente(String? value) => cliente = value;
  @action
  setStatus(String? value) => status = value;
  @action
  setData(String? value) => data = value;
  @action
  setValor(String? value) => valor = value;
  @action
  setUuid(String? value) => uuid = value;
  @action
  setSituation(String? value) => situation = value;

  @action
  setButtons(Row? value) => botoes = value;

  _PedidosModelBase(
      {this.codigo, this.cliente, this.status, this.data, this.valor, this.uuid});

  _PedidosModelBase.fromJson(Map<String, dynamic> json)
      : codigo = json['order_number'],
        cliente = json['user']['name'],
        status = json['status_message'],
        data = json['created_at'],
        valor = json['order_price'],
        uuid = json['uuid'],
        situation = json['status_original'];

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'cliente': cliente,
        'status': status,
        'data': data,
        'valor': valor,
        'uuid': uuid,
        'situation': situation,
      };
}
