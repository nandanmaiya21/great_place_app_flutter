import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as LOC;
import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class PickLocation extends StatefulWidget {
  static const routeName = '/pick_location';
  const PickLocation({super.key});

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  final controller = TextEditingController();
  var _placefound = false;
  List<Location>? locations;

  Future<List<Location>> getPlace(String add) async {
    try {
      if (add == null) {
        throw Exception('Not valid Address!');
      }

      locations = await locationFromAddress(add);

      //print(locations);

      setState(() {
        _placefound = true;
      });

      return locations!;
    } catch (e) {
      rethrow;
    }
  }

  String getUrl(Location loc) {
    final saticMapImageUrl = LocationHelper.generateLocationPreViewImage(
        latitude: loc.latitude,
        longitude: loc.longitude,
        width: 600,
        height: 600);
    return saticMapImageUrl;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Location')),
      body: _placefound == true
          ? SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(getUrl(locations![0]))),
                    ),
                    onTap: () {
                      Map<String, double> loc = {
                        'latitude': locations![0].latitude,
                        'longitude': locations![0].longitude,
                      };
                      Navigator.of(context)
                          .pushNamed(MapScreen.routeName, arguments: loc);
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Map<String, double> loc = {
                          'latitude': locations![0].latitude,
                          'longitude': locations![0].longitude,
                        };
                        Navigator.of(context).pop(loc);
                      },
                      child: Text('Select Location')),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _placefound = false;
                        });
                      },
                      child: Text('Reselect Location')),
                ],
              ),
            )
          : Container(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      label: Text('Address'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () => getPlace(controller.text),
                    child: Text('Search')),
              ],
            )),
    );
  }
}
