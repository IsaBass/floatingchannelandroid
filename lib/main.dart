import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Channel Android'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  static const platform = const MethodChannel("floating_button");

  @override
  void initState() {
    super.initState();

    platform.setMethodCallHandler((call) {
      if (call.method == "touch") {
        setState(() {
          _counter += 1;
        });
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              ElevatedButton(
                child: Text('Create'),
                onPressed: () {
                  platform.invokeMethod("create");
                },
              ),
              ElevatedButton(
                child: Text('Show'),
                onPressed: () {
                  platform.invokeMethod("show");
                },
              ),
              ElevatedButton(
                child: Text('Hide'),
                onPressed: () {
                  platform.invokeMethod("hide");
                },
              ),
              ElevatedButton(
                child: Text('Verify'),
                onPressed: () {
                  platform
                      .invokeMethod("isShowing")
                      .then((value) => print("isShowing = $value"));
                },
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
