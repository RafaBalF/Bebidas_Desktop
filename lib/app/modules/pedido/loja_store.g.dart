// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loja_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LojaStore on _LojaStoreBase, Store {
  late final _$lojaOpenCloseAtom =
      Atom(name: '_LojaStoreBase.lojaOpenClose', context: context);

  @override
  bool? get lojaOpenClose {
    _$lojaOpenCloseAtom.reportRead();
    return super.lojaOpenClose;
  }

  @override
  set lojaOpenClose(bool? value) {
    _$lojaOpenCloseAtom.reportWrite(value, super.lojaOpenClose, () {
      super.lojaOpenClose = value;
    });
  }

  late final _$lojaOpenCloseMensageAtom =
      Atom(name: '_LojaStoreBase.lojaOpenCloseMensage', context: context);

  @override
  String? get lojaOpenCloseMensage {
    _$lojaOpenCloseMensageAtom.reportRead();
    return super.lojaOpenCloseMensage;
  }

  @override
  set lojaOpenCloseMensage(String? value) {
    _$lojaOpenCloseMensageAtom.reportWrite(value, super.lojaOpenCloseMensage,
        () {
      super.lojaOpenCloseMensage = value;
    });
  }

  late final _$_LojaStoreBaseActionController =
      ActionController(name: '_LojaStoreBase', context: context);

  @override
  dynamic changeLojaOpenClose(bool? value) {
    final _$actionInfo = _$_LojaStoreBaseActionController.startAction(
        name: '_LojaStoreBase.changeLojaOpenClose');
    try {
      return super.changeLojaOpenClose(value);
    } finally {
      _$_LojaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeLojaOpenCloseMensage(String? value) {
    final _$actionInfo = _$_LojaStoreBaseActionController.startAction(
        name: '_LojaStoreBase.changeLojaOpenCloseMensage');
    try {
      return super.changeLojaOpenCloseMensage(value);
    } finally {
      _$_LojaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lojaOpenClose: ${lojaOpenClose},
lojaOpenCloseMensage: ${lojaOpenCloseMensage}
    ''';
  }
}
