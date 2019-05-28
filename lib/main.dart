import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'My Weather'),
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

  List<String> cities = ["Marrakech", "Rabat", "Casablanca"];
  String selectedCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      drawer: new Drawer(
        child: new Container(
          child: new ListView.builder(
            itemCount: cities.length + 2,
              itemBuilder: (context, i) {
              if (i == 0) {
                return DrawerHeader(
                  decoration: BoxDecoration(color: Colors.lightBlue),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      textWithStyle("Cities", fontSize: 22.0),
                      new RaisedButton(
                        color: Colors.white,
                          elevation: 8.0,
                          child: textWithStyle("Add City", color: Colors.blue),
                          onPressed: () {

                          }),
                    ],
                  ),
                );
              } else if (i == 1) {
                return new ListTile(
                  title: textWithStyle("My current city"),
                  onTap: () {
                    setState(() {
                      selectedCity = null;
                      Navigator.pop(context);
                    });
                  },
                );
              } else {
                String city = cities[i - 2];
                return new ListTile(
                  title: textWithStyle(city),
                  onTap: () {
                    setState(() {
                      selectedCity = city;
                      Navigator.pop(context);
                    });
                  },
                );
              }
              }),
          color: Colors.blue,
        ),
      ),
      body: Center(
        child: new Text((selectedCity == null)? "Current city": selectedCity),
      ),
    );
  }


  Text textWithStyle(String data, {color: Colors.white, fontSize: 18.0, fontStyle: FontStyle.italic, textAlign: TextAlign.center}) {
    return new Text(
      data,
      textAlign: textAlign,
      style: new TextStyle(
        color: color,
        fontSize: fontSize,
        fontStyle: fontStyle
      ),
    );
  }
}
