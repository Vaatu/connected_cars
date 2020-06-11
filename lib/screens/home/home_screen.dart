import 'package:connectedcar/components/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
          thirtyToTenText =DateTime.now().difference(thirtyToTenDateStart).inSeconds;
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
        SfRadialGauge(
            title: GaugeTitle(
                text: 'Speedometer',
                textStyle: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold)),
            axes: <RadialAxis>[
              RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0,
                    endValue: 50,
                    color: Colors.green,
                    startWidth: 10,
                    endWidth: 10),
                GaugeRange(
                    startValue: 50,
                    endValue: 100,
                    color: Colors.orange,
                    startWidth: 10,
                    endWidth: 10),
                GaugeRange(
                    startValue: 100,
                    endValue: 150,
                    color: Colors.red,
                    startWidth: 10,
                    endWidth: 10)
              ], pointers: <GaugePointer>[
                NeedlePointer(
                    value: speedInKph == null
                        ? 0
                        : double.parse(speedInKph.toStringAsFixed(0)))
              ], annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Container(
                        child: Text(
                            '${speedInKph == null ? 0 : speedInKph.toInt().toString()}',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold))),
                    angle: 80,
                    positionFactor: 0.5)
              ])
            ]),
        SizedBox(
          height: 36.0,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: ReusableCard(
                colour: Color(0xFF1D1E33),
                cardChild: Padding(
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
                            style: TextStyle(
                                fontSize: 36, fontWeight: FontWeight.bold),
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
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ReusableCard(
                colour: Color(0xFF1D1E33),
                cardChild: Padding(
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
                            style: TextStyle(
                                fontSize: 36, fontWeight: FontWeight.bold),
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
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
