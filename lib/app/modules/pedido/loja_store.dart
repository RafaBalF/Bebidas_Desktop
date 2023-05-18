// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:ped/api.dart';

part 'loja_store.g.dart';

class LojaStore = _LojaStoreBase with _$LojaStore;

abstract class _LojaStoreBase with Store {
  @observable
  bool? lojaOpenClose = false;

  @observable
  String? lojaOpenCloseMensage = 'Seu estabelecimento está Offline.';

  @action
  changeLojaOpenClose(bool? value) => lojaOpenClose = value;

  @action
  changeLojaOpenCloseMensage(String? value) => lojaOpenCloseMensage = value;



  // Future<VerificaLojaOnline> verificaLojaOnlineGetApi(String idPdv) async {
  //   var request = http.MultipartRequest('POST',
  //       Uri.parse('https://leonardopolo.com.br/casca-api/verificaligado.php'));
  //   request.fields.addAll({'idpdv': idPdv});

  //   http.StreamedResponse response = await request.send();

  //   var dados = jsonDecode(await response.stream.bytesToString());
  //   var data = VerificaLojaOnline.fromJson(dados);
  //   changeLojaOpenClose(data.observacao);
  //   return data;
  // }

  ligaDesligaLojaGetApi(String? token, bool openClose) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var request = http.Request(
        'POST',
        Uri.parse(
            '$API_URL/company/makeCompanyOnlineOffline'));
    request.body = json.encode({"status": openClose});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var dados = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      changeLojaOpenClose(dados['CompanyStatus']);

      if(lojaOpenClose ==  true){
        changeLojaOpenCloseMensage('Seu estabelecimento está Online.');
      } else {
        changeLojaOpenCloseMensage('Seu estabelecimento está Offline.');
      }

      return dados;
    }

    return dados;
  }
}

// class VerificaLojaOnline {
//   String? status;
//   String? logado;
//   String? observacao;

//   VerificaLojaOnline({this.status, this.logado, this.observacao});

//   VerificaLojaOnline.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     logado = json['logado'];
//     observacao = json['observacao'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['logado'] = this.logado;
//     data['observacao'] = this.observacao;
//     return data;
//   }
// }

// class LigaDesligaLoja {
//   String? status;
//   String? idpdv;
//   String? isActive;

//   LigaDesligaLoja({this.status, this.idpdv, this.isActive});

//   LigaDesligaLoja.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     idpdv = json['idpdv'];
//     isActive = json['is_active'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['idpdv'] = this.idpdv;
//     data['is_active'] = this.isActive;
//     return data;
//   }
// }
