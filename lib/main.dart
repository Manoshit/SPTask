import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/providers/orderProvider.dart';
import 'package:task/screens/orderListScreen.dart';
import './screens/signInScreen.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) { 
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Orders()),
      ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
        title: 'Sign in',
        home: Scaffold(
          appBar:  AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent
          ),
          body: GestureDetector(// used to close the soft keyboard when user clicks anywhere except the form field
             onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Signin()),
        ),
        routes: { 
      orderListScreen.routeName :(ctx)=>orderListScreen(),
        },
      ),
    );
  }
}