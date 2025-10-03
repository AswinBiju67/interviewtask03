import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:interviewtask03/model/productmodel.dart';
import 'package:interviewtask03/service/api.dart';


class Homescreencontroller with ChangeNotifier {
  bool isLoading = false;
  bool isProductLoading = false;
  int selectedindex = 0;
  List<ProductModel> product=[];
  

  Future<void> getproducts({String? categroy}) async {
    String endpointUrl= categroy == null ? "products" : "products/category/$categroy";
    final url = Uri.parse(AppConfi.baseUrl + endpointUrl);
    try {
      isProductLoading = true;
      notifyListeners();
      final response = await http.get(url);
      if (response.statusCode == 200) {
        product = productModelFromJson(response.body);
      }
    } catch (e) {}
    isProductLoading = false;
    notifyListeners();
  }

 
}
