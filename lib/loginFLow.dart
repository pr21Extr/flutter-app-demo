import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'todoListScreen.dart';

class LoginFlow extends StatefulWidget {
  @override
  _LoginFlowState createState() => _LoginFlowState();
}

class _LoginFlowState extends State<LoginFlow> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _username;
  String? _password;
  bool _obscureText = true;
  bool _rememberMe = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 30,

                          color: Colors.black),
                    ),
                  Image.asset(
                    'assets/header.jpg',
                    height: 100,
                    width: 90,
                  ),
                ],

              ),


              SizedBox(height: 70),
              Card(
                elevation: 5,
                color: Colors.white60,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                      style: TextStyle(color: Colors.black54),
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person,color: Colors.deepPurpleAccent),
                          labelStyle: TextStyle(color: Colors.deepPurpleAccent),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyanAccent),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _username = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(color: Colors.black54),
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock, color: Colors.deepPurpleAccent), // Set the icon color here
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(
                              _obscureText ? Icons.visibility : Icons.visibility_off,
                              color: Colors.deepPurpleAccent, // Set the icon color here
                            ),
                          ),
                          labelStyle: TextStyle(color: Colors.deepPurpleAccent),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyanAccent),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Radio<bool>(
                    value: true,
                    groupValue: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                    activeColor: Colors.deepPurpleAccent,
                  ),
                  Text('Remember me',
                      style: TextStyle(color: Colors.purpleAccent,fontSize: 18)),
                  SizedBox(width: 16, height: 40),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _performLogin();
                      }
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 30),
                      primary: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Adjust the value as needed for the desired roundness
                      ),
                    ),
                  ),

                  SizedBox(height: 80),
                ],

              ),

              SizedBox(height: 80),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/footer.jpg',
                    height: 80,
                    width: 90,
                  ),
                  Text('Sign up', style: TextStyle(fontSize: 30, color: Colors.black)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _performLogin() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      'username': _username,
      'password': _password,
    };

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map<String, dynamic> responseData = json.decode(response.body);
        print('Login successful! Response: $responseData');
        _navigateToTodosScreen(); // Navigate to TodosScreen after successful login
      } else {
        print('Login failed. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred:   ''  $e');
    }
  }

  void _navigateToTodosScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodosScreen()),
    );
  }
}
