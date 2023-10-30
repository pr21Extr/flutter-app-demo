// import 'package:camera/camera.dart';
// import 'package:firstapptwo/camera/camera.dart';
// import 'package:firstapptwo/expansionList.dart';
// import 'package:firstapptwo/firestoreData.dart';
// import 'package:firstapptwo/loginFLow.dart';
// import 'package:firstapptwo/otpLogin.dart';
// import 'package:firstapptwo/staggeredGrid.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'myHomePage.dart';
// import 'package:firstapptwo/todoListScreen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
//
//
// late List<CameraDescription> cameras;
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensure that Flutter is initialized
//   cameras = await availableCameras();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform, // Initialize Firebase
//   );
//   runApp(
//       ChangeNotifierProvider(
//         create: (context) => CameraProvider(),
//         child: MyApp(),
//       )
//   ); // First class to run
// }
//
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//
//     return MaterialApp(
//       title: "Check it out",
//       // theme: ThemeData.dark(),
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//       ),
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: {
//         'MyHomePage': (context) => MyHomePage(), // Define route for MyHomePage
//         '/': (context)=>LoginFlow(),
//         // '/': (context)=>StaggeredGridViewExample(),
//         // '/': (context)=>LoginWithPhone(),
//         // '/': (context)=>FireWrite(),
//         // '/': (context)=>HomePage(),
//
//         // '/': (context)=>CameraApp(),
//
//         '/todos': (context) => TodosScreen()
//          // Define route for TodosScreen
//       },
//     );
//   }
// }
//
// ///firebase,firestore,todoList, OTP login, staggered grid integrate into a better flow
//
//
//
//
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:dio_request_inspector/presentation/main/page/main_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

DioRequestInspector dioRequestInspector =
DioRequestInspector(isDebugMode: true, showFloating: false);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DioRequestInspectorMain(
      inspector: dioRequestInspector, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dio Request Inspector',
      navigatorKey: dioRequestInspector.getNavigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Dio _dio;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    _dio = Dio();
    _dio.interceptors.add(dioRequestInspector.getDioRequestInterceptor());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio Request Inspector Example'),
        backgroundColor: Colors.purple.withOpacity(0.6),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: _getRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.withOpacity(0.6),
              ),
              child: const Text("GET Request"),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: _getImageRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.withOpacity(0.6),
              ),
              child: const Text("GET Image Request"),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: _postRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.withOpacity(0.6),
              ),
              child: const Text("POST Request"),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: _postWithFormDataRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.withOpacity(0.6),
              ),
              child: const Text("POST with Form Data Request"),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: _errorRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.withOpacity(0.6),
              ),
              child: const Text("Error Request"),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: _seeInspector,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.withOpacity(0.6),
              ),
              child: const Text("See Inspector"),
            ),
          ],
        ),
      ),
    );
  }

  void _getRequest() {
    _dio.get<void>("https://63aea217ceaabafcf17f16b1.mockapi.io/get");
  }

  void _postRequest() {
    _dio.post("https://httpbin.org/post", data: {"name": "dio", "age": 25});
  }

  void _postWithFormDataRequest() async {
    var imageFile = await _picker.pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      FormData formData = FormData.fromMap({"name": "atung"});

      formData.files.add(MapEntry(
          "tes",
          await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          )));
      _dio.post("https://httpbin.org/post",
          data: formData,
          options: Options(headers: {
            "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZ2VudF9pZCI6ODQsImJyYW5jaF9pZCI6bnVsbCwiY3JvX2lkIjpudWxsLCJjcm9fbmFtZSI6bnVsbCwiZGV2aWNlX2lkIjoiUktRMS4yMDEyMTcuMDAyIiwiZW1haWwiOiJjaWFjaWFnb3JleUBnbWFpbC5jb20iLCJleHAiOjE2ODUzNzI5MjcsImdyb3VwX25hbWUiOm51bGwsImlkIjoiM2I5NWYxNjktZGVlYy00Y2RkLThhMTQtNDE4MmNhZmZjMWRlIiwiaXNfbWVyY2hhbnRfb25saW5lIjpmYWxzZSwiaXNfbmV3X3dnIjpmYWxzZSwiaXNfc2hvd19tZW51X2RlYWxlcl9zdWJzaWR5IjpmYWxzZSwibWVyY2hhbnRfYnJhbmNoX2lkIjoiIiwibmFtZSI6IlNlbGx5IEFnZW50IEJla2FzaSIsIm5payI6IjczODQ2NTMyOTE4MjczNjIiLCJyZWdpb25faWQiOm51bGwsInJvbGVfaWQiOiJmMDgwYWIxYi0xYzY0LTRhZWQtYTZjNi03MjI5NWNiOGNlNzYiLCJyb2xlX25hbWUiOiJhZ2VudCIsInN1cHBsaWVyX2lkIjoiIiwidXNlcl90eXBlIjoiS01PQiJ9.4MnU4Ul1Nnni87FvnR0bBQOonzzurdxxt3t8LYZ5tf4"
          }));
    }
  }

  void _errorRequest() {
    _dio.get<void>("https://httpbin.org/status/404");
  }

  void _seeInspector() {
    dioRequestInspector.navigateToDetail();
  }

  void _getImageRequest() {
    _dio.get<void>("https://httpbin.org/image/png");
  }
}