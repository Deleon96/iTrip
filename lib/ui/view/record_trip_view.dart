import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:itrip/data/model/trip.dart';
import 'package:itrip/ui/widget/common/app_bar_primary.dart';
import 'package:itrip/ui/widget/common/button_link.dart';

class RecordTripView extends StatefulWidget {
  final Trip trip;
  const RecordTripView({super.key, required this.trip});

  @override
  State<RecordTripView> createState() => _RecordTripViewState();
}

class _RecordTripViewState extends State<RecordTripView> {
  final ValueNotifier<Position?> _position = ValueNotifier(null);

  Future<void> getCurrentLocation() async {
    _position.value = await Geolocator.getCurrentPosition();
  }

  void currentLocationLive() {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (Position? position) {
            _position.value = position;
          },
        );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      currentLocationLive();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPrimary(context: context),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _position,
          builder: (BuildContext context, value, Widget? child) {
            return Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Latitude: ${_position.value?.latitude}",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "Longitude: ${_position.value?.longitude}",
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        height: 52,
                        child: ButtonLink(
                          onClick: () {
                            Navigator.pop(context);
                          },
                          text: "Finalizar",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.my_location),
        onPressed: () {
          getCurrentLocation();
        },
      ),
    );
  }
}
