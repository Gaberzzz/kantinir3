import 'package:kantinir_mobile_app/screens/theme.dart';
import 'package:kantinir_mobile_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:kantinir_mobile_app/screens/authenticate/authenticate.dart';
import 'package:kantinir_mobile_app/shared/constants.dart';
import 'package:kantinir_mobile_app/screens/authenticate/register.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  final Function toggleView;
  SignInPage({super.key, required this.toggleView});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();

  // key to associate data
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  // error state
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Scaffold(
        backgroundColor: themeProvider.backgroundColor,
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Sign in to KanTinir'),
          actions: <Widget>[
            TextButton.icon(
                icon: Icon(Icons.person),
                label: Text('Register'),
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {
                  widget.toggleView();
                })
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Image.asset('images/person1.png', width: 350, height: 280),
                const Text(
                  "Let's get you in!",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Color.fromARGB(255, 235, 235, 235),
                    hintText: 'Enter email',
                    hintStyle: TextStyle(
                      color: error.isNotEmpty
                          ? Colors.red
                          : Colors.black, // Change color when error occurs
                    ),
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Enter Password',
                    fillColor: Color.fromARGB(255, 235, 235, 235),
                  ),
                  obscureText: true,
                  validator: (val) => val!.length < 6
                      ? 'Enter a password 6+ characters long'
                      : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:
                        Color(0xFF11CDA7), // Set the button color to #11CDA7
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Make the button rounded
                    ),
                    minimumSize:
                        Size(300, 40), // Set the width and height you desire
                  ),
                  child: const Text('Sign in',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() => error = 'credentials are not valid.');
                      }
                    } else {
                      setState(() => error = 'credentials are not valid.');
                    }
                  },
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            )),
          ),
        ),
      );
    });
  }
}
