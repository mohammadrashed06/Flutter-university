import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/universities_response_model.dart';
final messagesFamily = ChangeNotifierProviderFamily<GetDataFromApi, String>((ref, country) =>GetDataFromApi(country));


class GetDataFromApi extends ChangeNotifier{
  List<UniversitiesResponseModel> listDataModel = [];
  List<UniversitiesResponseModel> partOfListPagination = [];
  bool isLoading = false;
  int pageNumber =0;
  int pageLength = 15;


  GetDataFromApi(String? country){
    getData(country);
  }

  Future getData(String? country) async {
    isLoading = true;
    notifyListeners();
    final queryParameters= {
      'country': country,
    };
    listDataModel = [];
    http.Response response = 
        await http.get(Uri.http('universities.hipolabs.com','search',queryParameters));

    var data = jsonDecode(response.body);
    for(int i =0; i< data.length; i++){
      listDataModel.add(UniversitiesResponseModel.fromJson(data[i]));
    }
    if(listDataModel.length >20){
      partOfListPagination.addAll(listDataModel.getRange(pageNumber, pageLength));
      pageNumber++;
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }
}