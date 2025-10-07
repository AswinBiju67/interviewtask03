import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:interviewtask03/model/productmodel.dart';
import 'package:interviewtask03/service/api.dart';
import 'package:interviewtask03/service/authhandel.dart';


class Homescreencontroller with ChangeNotifier {
  bool isLoading = false;
  bool isProductLoading = false;
  int selectedindex = 0;
  List<ProductModel> product=[];
  bool isUserLoading = true;
  String? userName;
  String? userEmail;

  Future<void> getproducts({String? categroy}) async {
    final url = Uri.parse(AppConfi.baseUrl);
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

  Future<void> loadUserData() async {
    isUserLoading = true;
    notifyListeners();
    
    userName = await AuthHandler.getUserName();
    userEmail = await AuthHandler.getUserEmail();
    
    isUserLoading = false;
    notifyListeners();
  }
 
}
