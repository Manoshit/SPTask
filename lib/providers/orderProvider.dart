import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:task/common/resources/sharedPreferences.dart';

class Orders with ChangeNotifier{

List orders=[];


List  get getOrders{
return orders;
}

Future<void> getOrderList(BuildContext ctx) async {
  String baseurl = 'http://devapi.trof.me';
  String token = await getToken();
  Map<String,dynamic> orderListBody={
    "vendor_id": "5ef97f5849c90a5f17ec7dec",
    "order_type": ["reject", "done"]
  };
  print(token);
  final response = await http.post('$baseurl/v1/order/vendor/list/1', body: jsonEncode(orderListBody), headers: {
    'accept':'*/*',
    'Content-Type': 'application/json',
    'authtoken': token
  });
  
if(response.statusCode==403){
  Navigator.pop(ctx); //pops back to login screen if status code 403 is found
}
else{
var parsedData=jsonDecode(response.body);
orders.clear();
orders.addAll(parsedData['data']['order']);//add the data that is retrieved from api to the list that is to be shown after refreshing
notifyListeners();
}

}


}