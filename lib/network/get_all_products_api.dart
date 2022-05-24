import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:fashion_store/constants/url.dart';
import 'package:fashion_store/model/homescreen_item_model.dart';

Future<HomeScreenModel> getAllProductsApi() async{
  final response = await http.get(
    Uri.parse(getAllProductsUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }
  );
  if (response.statusCode==200) {
    return HomeScreenModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Server Error');
  }
}