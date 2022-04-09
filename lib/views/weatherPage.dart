import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'dataset.dart';
import 'detailPage.dart';
import 'extraWeather.dart';

Weather? currentTemp;
Weather? tomorrowTemp;
List<Weather> todayWeather = new List<Weather>.empty(growable: true);
// new List<ArticleModel>.empty(growable: true);
List<Weather> sevenDay = new List<Weather>.empty(growable: true);
String lat = "0.31628000";
String lon = "32.58219000";
String city = "Kampala";

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  getData() async {
    fetchData(lat, lon, city).then((value) {
      currentTemp = value[0];
      todayWeather = value[1];
      tomorrowTemp = value[2];
      sevenDay = value[3];
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: currentTemp == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [CurrentWeather(getData), TodayWeather()],
            ),
    );
  }
}

/* CURRENT WEATHER */
class CurrentWeather extends StatefulWidget {
  final Function() updateData;
  CurrentWeather(this.updateData);
  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  bool searchBar = false;
  bool updating = false;
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          if (searchBar)
            setState(() {
              searchBar = false;
            });
        },
        child: GlowContainer(
          height: MediaQuery.of(context).size.height - 350,
          margin: EdgeInsets.all(2),
          padding: EdgeInsets.only(/* top: 10, */ left: 30, right: 30),
          glowColor: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: Color(0xff00A1FF),
          spreadRadius: 5,
          child: Column(
            children: [
              Container(
                child: searchBar
                    ? TextField(
                        focusNode: focusNode,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Enter a city Name"),
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) async {
                          CityModel? temp = await fetchCity(value);
                          if (temp == null) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.blueGrey,
                                    title: Text("City not found"),
                                    content: Text("Please check the city name"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Ok"))
                                    ],
                                  );
                                });
                            searchBar = false;
                            return;
                          }
                          city = temp.name;
                          lat = temp.lat;
                          lon = temp.lon;
                          updating = true;
                          setState(() {});
                          widget.updateData();
                          searchBar = false;
                          updating = false;
                          setState(() {});
                        },
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            CupertinoIcons.square_grid_2x2,
                            color: Colors.white,
                          ),
                          Row(
                            children: [
                              Icon(CupertinoIcons.map_fill,
                                  color: Colors.white),
                              GestureDetector(
                                onTap: () {
                                  searchBar = true;
                                  setState(() {});
                                  focusNode.requestFocus();
                                },
                                child: Text(
                                  " " + city,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.more_vert, color: Colors.white)
                        ],
                      ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.2, color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  updating ? "Updating" : "Updated",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 320,
                child: Stack(
                  children: [
                    Image(
                      image: AssetImage(currentTemp!.image),
                      fit: BoxFit.scaleDown,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Center(
                          child: Column(
                        children: [
                          GlowText(
                            currentTemp!.current.toString(),
                            style: TextStyle(
                                height: 0.1,
                                color: Colors.white,
                                fontSize: 70,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(currentTemp!.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(currentTemp!.day,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ))
                        ],
                      )),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              ExtraWeather(currentTemp!)
            ],
          ),
        ),
      ),
    );
  }
}

/* TODAY'S WEATHER */
class TodayWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today",
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return DetailPage(tomorrowTemp!, sevenDay);
                  }));
                },
                child: Row(
                  children: [
                    Text(
                      "7 days ",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                      size: 15,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 30,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WeatherWidget(todayWeather[0]),
                  WeatherWidget(todayWeather[1]),
                  WeatherWidget(todayWeather[2]),
                  WeatherWidget(todayWeather[3])
                ]),
          )
        ],
      ),
    );
  }
}

/* WEATHER WIDGET */
class WeatherWidget extends StatelessWidget {
  final Weather weather;
  WeatherWidget(this.weather);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(width: 0.2, color: Colors.white),
          borderRadius: BorderRadius.circular(35)),
      child: Column(
        children: [
          Text(
            weather.current.toString() + "\u00B0",
            style: TextStyle(color: Colors.blueGrey, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Image(
            image: AssetImage(weather.image),
            width: 50,
            height: 50,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            weather.time,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
