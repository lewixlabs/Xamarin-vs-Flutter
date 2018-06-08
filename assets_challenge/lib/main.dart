import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assets Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: AssetsChallengeHomePage(),
    );
  }
}

class AssetsChallengeHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Assets Demo'),
        centerTitle: true,
      ),
      body: new Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
                
                children: <Widget>[
                  Text(
                    'David di Michelangelo',
                    style: TextStyle(fontFamily: 'Elegant', fontSize: 45.0, color: Colors.cyan),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset('assets/img/david.jpg'),
                  SizedBox(height: 8.0),
                  new GestureDetector(
                      child: Text(
                        'Foto di Jörg Bittner Unna\nOpera propria',
                        style: TextStyle(fontFamily: 'Elegant', fontSize: 45.0),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () async {
                        await launch('https://commons.wikimedia.org/w/index.php?curid=46495986');
                      })
                ])),
      ),
    );
  }
}
