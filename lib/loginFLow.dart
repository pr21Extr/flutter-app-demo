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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        color: Colors.white60,
        padding: const EdgeInsets.all(20.0),
    child: Align(
    alignment: Alignment.topLeft, // Align the column to the top left
    child: Padding(
    padding: const EdgeInsets.only(top: 50.0), // Adjust top padding to raise the login elements higher
    child: Form(
    key: _formKey,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    // Logo or App Icon (Optional)
    // Image.asset(
    //   'assets/app_logo.png',
    //   height: 150,
    //   width: 150,
    // ),
    Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    Text("Login",
    style: TextStyle(
      fontSize: 30
    ),
    ),
    ],
    ),
    SizedBox(height: 25),
    SizedBox(height: 100),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
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
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
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
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // Align the button to the right
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _performLogin();
                      }
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      // Set the button's width to 120 (adjust as needed)
                      minimumSize: Size(120, 40),
                      primary:Colors.deepPurpleAccent
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
      print('Error occurred: $e');
    }
  }

  void _navigateToTodosScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodosScreen()),
    );
  }
}
