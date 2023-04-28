import 'package:mobx/mobx.dart';
import 'package:ped/model/status_model.dart';

part 'paginator_model.g.dart';

class PaginatorModel = _PaginatorModelBase with _$PaginatorModel;

abstract class _PaginatorModelBase  with Store
{
  @observable
  late int? currentPage;
  @observable
  late int? totalPages;

  @action
  setCurrentPage(int? value) => currentPage = value;

  _PaginatorModelBase(
      {this.currentPage, this.totalPages});

  _PaginatorModelBase.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'],
        totalPages = json['last_page'];

  Map<String, dynamic> toJson() => {
        'currentPage': currentPage,
        'totalPages': totalPages,
      };
}