import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapptwo/otpLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'todoListScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:math';



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
  late SharedPreferences _prefs;
  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }



  void _saveHashedPassword(String plainPassword) async {

    final salt = Random().hashCode.toString();
    final codec = Utf8Codec();
    final bytes = codec.encode(plainPassword + salt);
    final digest = sha256.convert(bytes);

    final hashedPassword = digest.toString();

    await _prefs.setString('hashedPassword', hashedPassword);
  }

  void _loadSavedCredentials() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = _prefs.getString('usernamePrefill') ?? '';
      _password = _prefs.getString('passwordPrefill') ?? '';
    });
  }

  void navToOTP(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>const LoginWithPhone()),
    );
  }


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

              Expanded(
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
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
              ),


              const SizedBox(height: 70),

              Card(
                elevation: 5,
                color: Colors.white60,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _username,
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
                        initialValue: _password,
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
                    child: Text(' Login'),
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

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children:[

                  ElevatedButton(
                    onPressed: () {
                      signInwithGoogle();


                    },
                    child: Text('Google Login'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 30),
                      primary: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Adjust the value as needed for the desired roundness
                      ),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      // Navigate to OTP screen
                      navToOTP(context);


                    },
                    child: Text('OTP Login'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 30),
                      primary: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Adjust the value as needed for the desired roundness
                      ),
                    ),
                  ),
                ]
              ),

              SizedBox(height: 40),

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




  signInwithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;



    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken:googleAuth?.accessToken,
      idToken:googleAuth?.idToken,
    );
    UserCredential userCred= await FirebaseAuth.instance.signInWithCredential(credential);
    print (userCred.user?.displayName);
  }

  void _performLogin() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    print('API call');

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

        _saveHashedPassword(_password!);

        _navigateToTodosScreen();
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
