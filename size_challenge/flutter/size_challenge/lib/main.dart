import 'package:flutter/material.dart';
import 'package:size_challenge/api.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'App Size Challenge',
      theme: new ThemeData(
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
      home: new MyHomePage(title: 'App Size Challenge'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _comicImage;
  Text _comicTitle;
  Widget _materialButtonContent;

  Widget _getDynamicButton(bool isLoadingComic) {
    if (isLoadingComic)
      return CircularProgressIndicator();
    else {
      return MaterialButton(
        child: Text(
          'Load Xkcd Comic',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: _loadComic,
        color: Colors.blue,
        splashColor: Colors.lightBlue,
      );
    }
  }

  @override
  initState() {
    super.initState();

    _comicImage = Icon(Icons.file_download);
    _comicTitle = Text('No comic loaded');

    _materialButtonContent = _getDynamicButton(false);
  }

  void _loadComic() async {
    setState(() {
      _materialButtonContent = _getDynamicButton(true);
      _comicTitle = Text('Loading');
    });

    var comic = await ComicApi().getComic();

    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

      if (comic == null) {
        _comicImage = Icon(Icons.file_download);
        _comicTitle = Text('No comic loaded');
      } else {
        _comicImage = comic.comicImage;
        _comicTitle = Text(comic.comicTitle);
      }
      _materialButtonContent = _getDynamicButton(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Column(
            // Column is also layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug paint" (press "p" in the console where you ran
            // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
            // window in IntelliJ) to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _comicImage,
              SizedBox(
                height: 14.0,
              ),
              _comicTitle,
              SizedBox(
                height: 14.0,
              ),
              _materialButtonContent
            ],
          ),
        ),
      ),
    );
  }
}
