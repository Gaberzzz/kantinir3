import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kantinir_mobile_app/screens/theme.dart';
import 'package:kantinir_mobile_app/services/auth.dart';
import 'package:kantinir_mobile_app/screens/authenticate/authenticate.dart';
import 'package:kantinir_mobile_app/shared/constants.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password1 = '';
  String password2 = '';
  String confirmPassword = '';
  String error = '';

  TextEditingController dateInput =
      TextEditingController(); // Initialize the controller
  String selectedEducationLevel = '';
  String dropdownvalue = 'Choose education level';
  var educationLevels = [
    'Choose education level',
    'Elementary',
    'High School',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'Ph.D.',
  ];
  String address = '';
  Color selectedColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Scaffold(
        backgroundColor: themeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: Color(0xFF11CDA7),
          elevation: 0.0,
          title: Text('Register to KanTinir'),
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign In'),
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
                widget.toggleView();
              },
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Text(
                    "Create your",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "account",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Enter a valid email',
                      fillColor: Color.fromARGB(255, 235, 235, 235),
                    ),
                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Enter a valid password',
                      fillColor: Color.fromARGB(255, 235, 235, 235),
                    ),
                    obscureText: true,
                    validator: (val) => val!.length < 6
                        ? 'Enter a password 6+ characters long'
                        : null,
                    onChanged: (val) {
                      setState(() => password1 = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Retype your password',
                      fillColor: Color.fromARGB(255, 235, 235, 235),
                    ),
                    obscureText: true,
                    validator: (val) =>
                        val != password1 ? 'Passwords do not match' : null,
                    onChanged: (val) {
                      setState(() => confirmPassword = val);
                    },
                  ),
                  SizedBox(height: 20.0),

                  TextField(
                    style: TextStyle(color: Colors.black),
                    controller: dateInput,
                    decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Enter Birthdate",
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          dateInput.text = formattedDate;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 12.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: DropdownButton(
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Set the style to change the text color
                      style: const TextStyle(
                          color: Color.fromARGB(255, 83, 98, 93), fontSize: 17),

                      // Array list of items
                      items: educationLevels.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),

                      // After selecting the desired option, it will
                      // change the button value to the selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 12.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Address',
                    ),
                    onChanged: (val) {
                      setState(() {
                        address = val;
                      });
                    },
                  ),
                  SizedBox(height: 12.0),
                  Text('Pick a color'),
                  // ColorPicker widget
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 200,
                      height: 800,
                      child: MaterialPicker(
                        pickerColor: Colors.white, //default color
                        onColorChanged: (Color color) {
                          selectedColor = color;
                          Provider.of<ThemeProvider>(context, listen: false)
                              .updateBackground(color);
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 12.0),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF11CDA7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: Size(300, 40),
                    ),
                    child: const Text('Register',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result =
                            await _auth.registerWithEmailAndPassword(
                                email, confirmPassword, selectedColor);
                        if (result == null) {
                          setState(
                              () => error = 'Please supply a valid email.');
                        }
                      }
                    },
                  ),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
