import 'package:flutter/material.dart';
import 'ui/screen/dashboard_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final routes = <String, WidgetBuilder>{
    "/dashboard": (BuildContext context) => Dashboard(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Interview Djubli',
        theme: ThemeData(fontFamily: 'OpenSans'),
        debugShowCheckedModeBanner: false,
        routes: routes,
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    loadingApp();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  loadingApp() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.of(context).pushAndRemoveUntil(
        // MaterialPageRoute(builder: (context) => Dashboard()),
        MaterialPageRoute(builder: (context) => const Dashboard()),
        (Route<dynamic> route) => false);
    print("pindah");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(flex: 45, child: SizedBox()),
                  Expanded(
                      flex: 55,
                      child: Column(
                        children: [
                          Center(
                              child: Text(
                            "Loading",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                          SizedBox(height: 10),
                          Center(
                              child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              strokeWidth: 5,
                              color: Color.fromARGB(255, 30, 192, 35),
                            ),
                          )),
                        ],
                      )),
                ],
              ))
        ],
      ),
    );
  }
}
