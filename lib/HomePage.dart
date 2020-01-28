import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getData();
    getData1();
    super.initState();
  }

  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  TextEditingController cityName= TextEditingController();
  var location="Nashik";

  fethData() {
    try {
       location=cityName.text;
    } catch (e) {
      print(e);
    }
   
    getData();
  }

  var url,url1;
  
  var data;
  Future<String> getData() async {
    url ='http://api.openweathermap.org/data/2.5/weather?q=$location,IN&units=metric&appid=64e220448cf1af7c0486e8e3dab0dd0a';
    url1 ="http://api.openweathermap.org/data/2.5/forecast?q=$location,IN&units=metric&appid=64e220448cf1af7c0486e8e3dab0dd0a&units=imperial";

    var responce = await http.get(Uri.encodeFull(url));
    print(responce.body);
    setState(() {
      var convertdata = json.decode(responce.body);
      data = convertdata;
    });
  }

  var data1;
  Future<String> getData1() async {
    var responce1 = await http.get(Uri.encodeFull(url1));
    print(responce1.body);
    setState(() {
      var convertdata1 = json.decode(responce1.body);
      data1 = convertdata1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: Center(
        child: (data == null && data1 == null)
            ? CircularProgressIndicator()
            : ListView(
                children: <Widget>[
                  Card(
                    elevation: 30,
                    margin: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10), 
                        child: ListTile(
                          leading: Icon(
                            Icons.menu,
                            size: 24,
                            color: Colors.black,
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              fethData();
                            },
                          ),
                          title: Center(
                            child: TextFormField(
                              controller: cityName,
                              decoration: new InputDecoration.collapsed(
                                hintText: 'Enter City Name',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 80,right: 80), 
                  ),
                  Container(
                    height: 250,
                    width: 400,
                    child: Image(
                      image: AssetImage("images/pic8.png"),
                    ),
                  ),
                  Card(
                    elevation: 25,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                            Color(0xFFfc00ff),
                            Color(0xFF00feada6)
                          ])),
                      // color: Colors.blueAccent[100],
                      margin: EdgeInsets.all(5),
                      height: 420,
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 100, top: 25),
                            child: Text(
                              "${(data['main']['temp'])} ℃",
                              style: TextStyle(
                                fontSize: 50,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 120, top: 25, left: 25),
                            child: Text(
                              "Weather: ${data['weather'][0]['description']}",
                              style: TextStyle(
                                letterSpacing: 3,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 120, top: 15, left: 25),
                            child: Text(
                              "Humidity ${(data['main']['humidity'])} %",
                              style: TextStyle(
                                letterSpacing: 3,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 120, top: 10, left: 25),
                            child: Text(
                              "Location - ${(data1['city']['name'])}",
                              style: TextStyle(
                                letterSpacing: 3,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Image(
                            height: 180,
                            width: 350,
                            image: AssetImage("images/pic5.png"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 5, top: 5, left: 5),
                            child: Text(
                              "Temperature ${(data['main']['temp_min'])}°/ ${(data['main']['temp_max'])}°",
                              style: TextStyle(
                                letterSpacing: 3,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10, right: 25),
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        "More Detais >",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 25,
                    //  color: Colors.pink,
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                Color(0xFF9796f0),
                                Color(0xFFfbc7d4)
                              ])),
                          margin: EdgeInsets.all(5),
                          height: 58,
                          width: double.infinity,
                          child: ListTile(
                            leading: Icon(Icons.wb_sunny),
                            title: Text(
                              "Today Cloudy",
                              style: TextStyle(
                                color: Colors.indigo[500],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              "${(data['main']['temp_min'])}°/ ${(data['main']['temp_max'])}°",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                Color(0xFF9796f0),
                                Color(0xFFfbc7d4)
                              ])),
                          margin: EdgeInsets.all(5),
                          height: 58,
                          width: double.infinity,
                          // color: Colors.blueAccent[100],
                          child: ListTile(
                            leading: Icon(Icons.wb_cloudy),
                            title: Text(
                              "Tomorrow Clear",
                              style: TextStyle(
                                color: Colors.indigo[500],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              "${(data['main']['temp_min'])}°/ ${(data['main']['temp_max'])}°",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                Color(0xFF9796f0),
                                Color(0xFFfbc7d4)
                              ])),
                          margin: EdgeInsets.all(5),
                          height: 58,
                          width: double.infinity,
                          child: ListTile(
                            leading: Icon(Icons.swap_calls),
                            title: Text(
                              "Cloudy",
                              style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                                "${(data['main']['temp_min'])}°/ ${(data['main']['temp_max'])}°",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                Color(0xFF9796f0),
                                Color(0xFFfbc7d4)
                              ])),
                          margin: EdgeInsets.all(5),
                          height: 58,
                          width: double.infinity,
                          child: ListTile(
                            leading: Icon(Icons.swap_calls),
                            title: Text(
                              "Wind",
                              style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text("${(data['wind']['speed'])}  km/h",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 25,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: 505,
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Card(
                            elevation: 25,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15),
                                  child: Text(
                                    "5 Day Weather Forecast",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: 58,
                                  width: double.infinity,
                                  color: Colors.blueAccent[100],
                                  child: ListTile(
                                    leading: Icon(Icons.not_listed_location),
                                    title: Text(
                                      "Temperature",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: Text(
                                        "${(data['main']['temp_min'])}°/ ${(data['main']['temp_max'])}°"),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: 58,
                                  width: double.infinity,
                                  color: Colors.blueAccent[100],
                                  child: ListTile(
                                    leading: Icon(Icons.location_on),
                                    title: Text(
                                      "Location",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing:
                                        Text("${(data1['city']['name'])}"),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: 58,
                                  width: double.infinity,
                                  color: Colors.blueAccent[100],
                                  child: ListTile(
                                    leading: Icon(Icons.location_city),
                                    title: Text(
                                      "Latitude",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: Text(
                                        "${(data1['city']['coord']['lat'])}"),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: 58,
                                  width: double.infinity,
                                  color: Colors.blueAccent[100],
                                  child: ListTile(
                                    leading: Icon(Icons.location_city),
                                    title: Text(
                                      "Longitude",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: Text(
                                        "${(data1['city']['coord']['lon'])}"),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(5),
                                  height: 58,
                                  width: double.infinity,
                                  color: Colors.blueAccent[100],
                                  child: ListTile(
                                    leading: Icon(Icons.swap_calls),
                                    title: Text(
                                      "Wind",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: Text(
                                        "${(data['wind']['speed'])}  km/h",
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Created By Champ",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
