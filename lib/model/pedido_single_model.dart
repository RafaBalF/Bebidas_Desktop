// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;

part 'pedido_single_model.g.dart';

class PedidoSingleModel = _PedidoSingleModelBase with _$PedidoSingleModel;

abstract class _PedidoSingleModelBase with Store {
  @observable
  String? status;
  @observable
  int? codigo;
  @observable
  String? nameCompany;
  @observable
  String? nameCliente;
  @observable
  List<Phones?> phoneCompany = [];
  @observable
  String? phoneClient;
  @observable
  String? cpfNota;
  @observable
  String? dateOrder;
  @observable
  String? obs;
  @observable
  double? deliveryFee;
  @observable
  String? orderTotal;
  @observable
  double? subTotal; //total - taxa de entrega(delivery fee)
  @observable
  String? methodPaymentName;
  @observable
  String? methodPaymentType;
  @observable
  String? addressCompany;
  @observable
  String? cepCompany;
  @observable
  String? numberCompany;
  @observable
  String? neighborhoodCompany;
  @observable
  String? cityCompany;
  @observable
  String? stateCompany;
  @observable
  String? complementCompany;
  @observable
  String? addressClient;
  @observable
  String? cepClient = '';
  @observable
  String? numberClient;
  @observable
  String? neighborhoodClient;
  @observable
  String? cityClient;
  @observable
  String? stateClient;
  @observable
  String? complementClient;
  @observable
  String? reference;
  @observable
  List<OrderProducts?> orderProducts = [];

  @action
  setCodigo(int? value) => codigo = value;
  @action
  setStatus(String? value) => status = value;
  @action
  setNameCompany(String? value) => nameCompany = value;
  @action
  setNameCliente(String? value) => nameCliente = value;
  @action
  setPhoneCompany(List<Phones> value) => phoneCompany = value;
  @action
  setPhoneClient(String? value) => phoneClient = value;
  @action
  setCpfNota(String? value) => cpfNota = value;
  @action
  setdataOrder(String? value) => dateOrder = value;
  @action
  setObs(String? value) => obs = value;
  @action
  setDeliveryFee(double? value) => deliveryFee = value;
  @action
  setOrderTotal(String? value) => orderTotal = value;
  @action
  setSubTotal(double? value) => subTotal = value;
  @action
  setMethodPaymentName(String? value) => methodPaymentName = value;
  @action
  setMethodPaymentType(String? value) => methodPaymentType = value;
  @action
  setAddressCompany(String? value) => addressCompany = value;
  @action
  setCityCompany(String? value) => cityCompany = value;
  @action
  setCepCompany(String? value) => cepCompany = value;
  @action
  setNumberCompany(String? value) => numberCompany = value;
  @action
  setNeighborhoodCompany(String? value) => neighborhoodCompany = value;
  @action
  setStateCompany(String? value) => stateCompany = value;
  @action
  setComplementCompany(String? value) => complementCompany = value;
  @action
  setaddressClient(String? value) => addressClient = value;
  @action
  setCepClient(String? value) => cepClient = value;
  @action
  setNumberClient(String? value) => numberClient = value;
  @action
  setNeighborhoodClient(String? value) => neighborhoodClient = value;
  @action
  setCityClient(String? value) => cityClient = value;
  @action
  setStateClient(String? value) => stateClient = value;
  @action
  setComplementClient(String? value) => complementClient = value;
  @action
  setReference(String? value) => reference = value;
  @action
  setOrderProducts(List<OrderProducts> value) => orderProducts = value;

  _PedidoSingleModelBase();

  // _PedidoSingleModelBase.fromJson(Map<String, dynamic> json) {
  //   setCepClient(json['orders'][0]['postcode']);
  //   setaddressClient(json['orders'][0]['address']);
  //   setNumberClient(json['orders'][0]['number']);
  //   setComplementClient(json['orders'][0]['complement']);
  //   setNeighborhoodClient(json['orders'][0]['neighborhood']);
  //   setCityClient(json['orders'][0]['city']);
  //   setStateClient(json['orders'][0]['state']);
  //   setStatus(json['orders'][0]['status_message']);
  //   setMethodPaymentName(json['orders'][0]['payment_method']['name']);
  //   setMethodPaymentType(json['orders'][0]['payment_method']['type']);
  //   setObs(json['orders'][0]['obs']);
  //   setOrderTotal(json['orders'][0]['order_price']);
  //   setDeliveryFee(json['orders'][0]['delivery_fee'] + .0);
  //   setPhoneClient(json['orders'][0]['tel']);
  //   setCodigo(json['orders'][0]['order_number']);
  //   setCpfNota(json['orders'][0]['cpfNota']);
  //   setdataOrder(json['orders'][0]['created_at_brt']);
  //   setNameCliente(json['orders'][0]['user']['name']);
  //   // orderTicket = null;
  //   setNameCompany(json['orders'][0]['company']['name']);
  //   setAddressCompany(json['orders'][0]['company']['address']['street']);
  //   setCepCompany(json['orders'][0]['company']['address']['postcode']);
  //   setNumberCompany(json['orders'][0]['company']['address']['number']);
  //   setNeighborhoodCompany(
  //       json['orders'][0]['company']['address']['neighborhood']);
  //   setCityCompany(json['orders'][0]['company']['address']['city']);
  //   setStateCompany(json['orders'][0]['company']['address']['state']);
  //   setComplementCompany(json['orders'][0]['company']['complement']);
  //   setPhoneCompany(List.from(json['orders'][0]['company']['phones'])
  //       .map((e) => Phones.fromJson(e))
  //       .toList());
  //   setOrderProducts(List.from(json['orders'][0]['order_products'])
  //       .map((e) => OrderProducts.fromJson(e))
  //       .toList());
  // }

  getPedidoByUuid(String? token, uuid) async {
    var headers = {'Authorization': 'Bearer $token'};

    var request = http.MultipartRequest(
        'GET', Uri.parse('http://127.0.0.1:8000/api/orders/$uuid'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var data = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      // PedidoSingleModel ped = PedidoSingleModel.fromJson(data);

      setCepClient(data['orders'][0]['postcode']);
    setaddressClient(data['orders'][0]['address']);
    setNumberClient(data['orders'][0]['number']);
    setComplementClient(data['orders'][0]['complement']);
    setReference(data['orders'][0]['reference']);
    setNeighborhoodClient(data['orders'][0]['neighborhood']);
    setCityClient(data['orders'][0]['city']);
    setStateClient(data['orders'][0]['state']);
    setStatus(data['orders'][0]['status_message']);
    setMethodPaymentName(data['orders'][0]['payment_method']['name']);
    setMethodPaymentType(data['orders'][0]['payment_method']['type']);
    setObs(data['orders'][0]['obs']);
    setOrderTotal(data['orders'][0]['order_price']);
    setDeliveryFee(data['orders'][0]['delivery_fee'] + .0);
    setPhoneClient(data['orders'][0]['tel']);
    setCodigo(data['orders'][0]['order_number']);
    setCpfNota(data['orders'][0]['cpfNota'] ?? 'Não');
    setdataOrder(data['orders'][0]['created_at_brt']);
    setNameCliente(data['orders'][0]['user']['name']);
    // orderTicket = null;
    setNameCompany(data['orders'][0]['company']['name']);
    setAddressCompany(data['orders'][0]['company']['address']['street']);
    setCepCompany(data['orders'][0]['company']['address']['postcode']);
    setNumberCompany(data['orders'][0]['company']['address']['number']);
    setNeighborhoodCompany(
        data['orders'][0]['company']['address']['neighborhood']);
    setCityCompany(data['orders'][0]['company']['address']['city']);
    setStateCompany(data['orders'][0]['company']['address']['state']);
    setComplementCompany(data['orders'][0]['company']['complement']);
    setPhoneCompany(List.from(data['orders'][0]['company']['phones'])
        .map((e) => Phones.fromJson(e))
        .toList());
    setOrderProducts(List.from(data['orders'][0]['order_products'])
        .map((e) => OrderProducts.fromJson(e))
        .toList());
    }
  }
}

class OrderProducts {
  OrderProducts({
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.finalPrice,
  });
  late final String productName;
  late final int quantity;
  late final double unitPrice;
  late final String finalPrice;

  OrderProducts.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    finalPrice = json['final_price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_name'] = productName;
    _data['quantity'] = quantity;
    _data['unit_price'] = unitPrice;
    _data['final_price'] = finalPrice;
    return _data;
  }
}

class Phones {
  Phones({
    required this.phone,
  });
  late final String phone;

  Phones.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phone'] = phone;
    return _data;
  }
}
