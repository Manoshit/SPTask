import 'package:flutter/material.dart';
import 'package:task/screens/orderListScreen.dart';
import '../api/signInApi.dart';
import 'package:toast/toast.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool autoValidate = false;
  bool isvalidated = false;
  bool show=false;

  TextEditingController passwordText = TextEditingController();

  TextEditingController emailText = TextEditingController();

  String validatePassword(String value) {
    if (value.length == 0)
      return 'This field must not be empty';
    else if (value.length < 6)
      return 'Password must be more than 5 charater';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value.length == 0)
      return 'This field must not be empty';
    else if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  void validateInputs() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      setState(() {
        isvalidated = true;
      });
    } else {
      setState(() {
        autoValidate = true;
        isvalidated = false;
      });
    }
  }
 

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidate: autoValidate,
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: ListView(
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextFormField(
                controller: emailText,
                decoration: InputDecoration(
                    errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                cursorColor: Colors.black,
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: TextFormField(
                controller: passwordText,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: (){
                      setState(() {
                        show=!show;
                      });
                      
                    },
                    child: Icon(Icons.remove_red_eye,color: Colors.black,)),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                    errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                obscureText: (show)?false:true,
                keyboardType: TextInputType.text,
                validator: validatePassword,
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: EdgeInsets.only(top: 35),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.blue,
                onPressed: () {
                  validateInputs();
                  if (isvalidated) {
                    print(emailText.text + passwordText.text);
                    showDialog( 
                        context: context,
                        builder: (_) {
                          return Center(child: CircularProgressIndicator());
                        });
                    loginApi(emailText.text, passwordText.text).then((val) {
                      Navigator.pop(context);//poping the dialog showing progress indicator
                      if (val == '1'){//condition for successfull login by user
                        Navigator.pushNamed(context, orderListScreen.routeName);
                         Toast.show('Logged In', context,
                            duration: 3,
                            backgroundColor: Colors.blue, gravity: Toast.BOTTOM);
                      }
                      else {
                        Toast.show(val, context, //shows error to user in a toast at the bottom of screen
                            duration: 5,
                            backgroundColor: Colors.blue, gravity: Toast.BOTTOM);
                      }
                    });
                  }
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
