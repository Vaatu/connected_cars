import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double speedInKph;
  DateTime tenToThirtyDateStart;
  double startSpeed;
  double endSpeed;
  DateTime tenToThirtyDateEnd;
  int tenToThirtyDuration;

  int thirtyToTenText;
  DateTime thirtyToTenDateStart;
  DateTime thirtyToTenDateEnd;
  int thirtyToTenDuration;
  double downSpeedStart;
  double downSpeedEnd;

  @override
  void initState() {
    super.initState();
    getCurrentSpeed();
  }

  Future<void> getCurrentSpeed() async {
    var geolocator = Geolocator();
    var options =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    geolocator.getPositionStream(options).listen((position) {
      setState(() {
        this.speedInKph = (position.speed * 1.609344);

        if (speedInKph > 0 && speedInKph <= 10 && startSpeed == null) {
          startSpeed = speedInKph;
          tenToThirtyDateStart = DateTime.now();
          print('start 10 to 30');
        } else if (speedInKph > 30 && startSpeed != null) {
          endSpeed = speedInKph;
          if (startSpeed != null) {
            tenToThirtyDuration =
                DateTime.now().difference(tenToThirtyDateStart).inSeconds;
            print(tenToThirtyDuration);
            tenToThirtyDateStart = null;
            startSpeed = null;
            endSpeed = null;
          }
        }
        //////////
        if (speedInKph >= 30 && downSpeedStart == null) {
          downSpeedStart = speedInKph;
          thirtyToTenDateStart = DateTime.now();
        } else if (speedInKph <= 10 && downSpeedStart != null) {
          downSpeedEnd = speedInKph;
          thirtyToTenDuration =
              DateTime.now().difference(thirtyToTenDateStart).inSeconds;
          thirtyToTenText =
              DateTime.now().difference(thirtyToTenDateStart).inSeconds;
          print('tenToThirtyDuration$tenToThirtyDuration');
          thirtyToTenDuration = null;
          downSpeedEnd = null;
          downSpeedStart = null;
        }
      });
    });
  }

  void tenToThirty() {}

  void checkSpeedRecord() {
    if (tenToThirtyDateStart == null) {
      tenToThirtyDateStart = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Current Speed',
          style: TextStyle(fontSize: 36.0),
        ),
        SizedBox(
          height: 36.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Text('${speedInKph.round()}',
                style: TextStyle(
                    fontFamily: 'digitalNum', fontSize: 72.0, color: Colors.green,fontWeight: FontWeight.bold)),
            Text(' kmh', style: TextStyle(fontSize: 18.0),)
          ],
        ),

        SizedBox(
          height: 36.0,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${tenToThirtyDuration == null ? '0' : '$tenToThirtyDuration'}',
                    style:
                        TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold,fontFamily: 'digitalNum',color: Colors.green,),
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text('sec')
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                'From 10 to 30 ',
                style: TextStyle(fontSize: 28.0),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 38.0,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${thirtyToTenDuration == null && thirtyToTenText == null ? '0' : '$thirtyToTenText'}',
                    style:
                    TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold,fontFamily: 'digitalNum',color: Colors.green),
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text('sec')
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                'From 30 to 10 ',
                style: TextStyle(fontSize: 28.0),
              ),
            ],
          ),
        )
      ],
    );
  }
}
