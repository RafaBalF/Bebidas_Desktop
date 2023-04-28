import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';

part 'loja_store.g.dart';

class LojaStore = _LojaStoreBase with _$LojaStore;

abstract class _LojaStoreBase with Store {
  @observable
  String? lojaOpenClose;

  @action
  changeLojaOpenClose(String? value) => lojaOpenClose = value;

  Future<VerificaLojaOnline> verificaLojaOnlineGetApi(String idPdv) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('https://leonardopolo.com.br/casca-api/verificaligado.php'));
    request.fields.addAll({'idpdv': idPdv});

    http.StreamedResponse response = await request.send();

    var dados = jsonDecode(await response.stream.bytesToString());
    var data = VerificaLojaOnline.fromJson(dados);
    changeLojaOpenClose(data.observacao);
    return data;
  }

  ligaDesligaLojaGetApi(String idPdv, String isActive) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://leonardopolo.com.br/casca-api/muda_statusconectado.php'));
    request.fields.addAll({'idpdv': idPdv, 'isactive': isActive});

    http.StreamedResponse response = await request.send();

    var dados = jsonDecode(await response.stream.bytesToString());
    var data = LigaDesligaLoja.fromJson(dados);
    return data;
  }
}

class VerificaLojaOnline {
  String? status;
  String? logado;
  String? observacao;

  VerificaLojaOnline({this.status, this.logado, this.observacao});

  VerificaLojaOnline.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    logado = json['logado'];
    observacao = json['observacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['logado'] = this.logado;
    data['observacao'] = this.observacao;
    return data;
  }
}

class LigaDesligaLoja {
  String? status;
  String? idpdv;
  String? isActive;

  LigaDesligaLoja({this.status, this.idpdv, this.isActive});

  LigaDesligaLoja.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    idpdv = json['idpdv'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['idpdv'] = this.idpdv;
    data['is_active'] = this.isActive;
    return data;
  }
}
