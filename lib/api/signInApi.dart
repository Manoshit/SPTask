import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:task/common/resources/sharedPreferences.dart';

Future<String> loginApi (String username,String password)async{
  String authToken;
  String baseurl='http://devapi.trof.me';
  String deviceToken='f8F_svMURdyRcnjRKzQ4VV:APA91bF9KgGzkTTT_uWQwuzpkuFti0uBlJb1jCuPcHrfc9W3JwM3gWB3gsdSH1ztT6ewoSFZxmZ21cSkXA3ysTjAZ6ejIkseczqT1HvUYYfqp20rNcJ_DIWI873aq0jtnwKrcvlrvgRW';
Map<String,dynamic> loginBody={ 'email':username,'password':password,'device_token':deviceToken};



final response=await  http.post('$baseurl/v1/auth/vendor/signin',body:loginBody );

var parsedData=jsonDecode(response.body);
print(parsedData);
if(parsedData['success']=='1'){
  authToken=parsedData['data']['authtoken'].toString();
  await setToken(authToken);
return '1';

}
else
return  parsedData['data']['message'];

}