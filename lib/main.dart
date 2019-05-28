import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

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

  String key = "cities";
  List<String> cities = [];
  String selectedCity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveCityToSharedPref();
  }
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
                          onPressed: addCity
                      ),
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
                  trailing: new IconButton(
                      icon: new Icon(Icons.delete, color: Colors.white,),
                      onPressed: (() => deleteCityFromSharedPref(city))
                  ),
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

  Future<Null> addCity() async {
    return showDialog(
      barrierDismissible: true,
        builder: (BuildContext buildContext){
        return new SimpleDialog(
          contentPadding: EdgeInsets.all(20.0),
          title: textWithStyle("Add a city", fontSize: 22.0, color: Colors.blue),
          children: <Widget>[
            new TextField(
              decoration: new InputDecoration(labelText: "City: "),
              onSubmitted: (String str){
                AddCityToSharedPref(str);
                Navigator.pop(buildContext);
              },
            )
          ],
        );
        },
        context: context);
  }

  void saveCityToSharedPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> liste = await sharedPreferences.getStringList(key);
    if (liste != null) {
      setState(() {
        cities = liste;
      });
    }
  }

  void AddCityToSharedPref(String city) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cities.add(city);
    await sharedPreferences.setStringList(key, cities);
    saveCityToSharedPref();
  }

  void deleteCityFromSharedPref(String city) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cities.remove(city);
    await sharedPreferences.setStringList(key, cities);
    saveCityToSharedPref();
  }

}
