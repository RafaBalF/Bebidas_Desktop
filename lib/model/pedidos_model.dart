// ignore_for_file: library_private_types_in_public_api, unused_element

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

  _PedidosModelBase(
      {this.codigo, this.cliente, this.status, this.data, this.valor});

  _PedidosModelBase.fromJson(Map<String, dynamic> json)
      : codigo = json['order_number'],
        cliente = json['user']['name'],
        status = json['status_message'],
        data = json['created_at'],
        valor = json['order_price'];

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'cliente': cliente,
        'status': status,
        'data': data,
        'valor': valor,
      };
}
