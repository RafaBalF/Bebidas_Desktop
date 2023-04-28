// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedidos_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PedidosModel on _PedidosModelBase, Store {
  late final _$codigoAtom =
      Atom(name: '_PedidosModelBase.codigo', context: context);

  @override
  int? get codigo {
    _$codigoAtom.reportRead();
    return super.codigo;
  }

  @override
  set codigo(int? value) {
    _$codigoAtom.reportWrite(value, super.codigo, () {
      super.codigo = value;
    });
  }

  late final _$clienteAtom =
      Atom(name: '_PedidosModelBase.cliente', context: context);

  @override
  String? get cliente {
    _$clienteAtom.reportRead();
    return super.cliente;
  }

  @override
  set cliente(String? value) {
    _$clienteAtom.reportWrite(value, super.cliente, () {
      super.cliente = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_PedidosModelBase.status', context: context);

  @override
  String? get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(String? value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$dataAtom =
      Atom(name: '_PedidosModelBase.data', context: context);

  @override
  String? get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(String? value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  late final _$valorAtom =
      Atom(name: '_PedidosModelBase.valor', context: context);

  @override
  String? get valor {
    _$valorAtom.reportRead();
    return super.valor;
  }

  @override
  set valor(String? value) {
    _$valorAtom.reportWrite(value, super.valor, () {
      super.valor = value;
    });
  }

  late final _$_PedidosModelBaseActionController =
      ActionController(name: '_PedidosModelBase', context: context);

  @override
  dynamic setCodigo(int? value) {
    final _$actionInfo = _$_PedidosModelBaseActionController.startAction(
        name: '_PedidosModelBase.setCodigo');
    try {
      return super.setCodigo(value);
    } finally {
      _$_PedidosModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCliente(String? value) {
    final _$actionInfo = _$_PedidosModelBaseActionController.startAction(
        name: '_PedidosModelBase.setCliente');
    try {
      return super.setCliente(value);
    } finally {
      _$_PedidosModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setStatus(String? value) {
    final _$actionInfo = _$_PedidosModelBaseActionController.startAction(
        name: '_PedidosModelBase.setStatus');
    try {
      return super.setStatus(value);
    } finally {
      _$_PedidosModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setData(String? value) {
    final _$actionInfo = _$_PedidosModelBaseActionController.startAction(
        name: '_PedidosModelBase.setData');
    try {
      return super.setData(value);
    } finally {
      _$_PedidosModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setValor(String? value) {
    final _$actionInfo = _$_PedidosModelBaseActionController.startAction(
        name: '_PedidosModelBase.setValor');
    try {
      return super.setValor(value);
    } finally {
      _$_PedidosModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
codigo: ${codigo},
cliente: ${cliente},
status: ${status},
data: ${data},
valor: ${valor}
    ''';
  }
}
