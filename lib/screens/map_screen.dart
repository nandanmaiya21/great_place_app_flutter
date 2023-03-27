import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map-screen';
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, double> loc =
        ModalRoute.of(context)!.settings.arguments as Map<String, double>;
    return Scaffold(
        appBar: AppBar(title: new Text('MapBox')),
        body: FlutterMap(
            options: MapOptions(
                center: LatLng((loc['latitude'])!, (loc['longitude'])!),
                minZoom: 10.0),
            children: [
              TileLayer(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/nandanmaiya/clelli632002601pj7vkd0fa9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibmFuZGFubWFpeWEiLCJhIjoiY2xlbGs2YzdsMGM0OTNxczRvejV5NHpzcyJ9.itSarJktRI93pkNv9pm_TA",
                  additionalOptions: {
                    'accessToken':
                        'pk.eyJ1IjoibmFuZGFubWFpeWEiLCJhIjoiY2xlbGs2YzdsMGM0OTNxczRvejV5NHpzcyJ9.itSarJktRI93pkNv9pm_TA',
                    'id': 'mapbox.mapbox-streets-v8'
                  }),
              MarkerLayer(
                markers: [
                  Marker(
                      point: LatLng(loc['latitude']!, loc['longitude']!),
                      builder: (ctx) => Container(
                            width: 45,
                            height: 45,
                            child: IconButton(
                              icon: Icon(Icons.location_on),
                              color: Colors.red,
                              iconSize: 45,
                              onPressed: () {
                                print('marker taped');
                              },
                            ),
                          ))
                ],
              )
            ]));
    ;
  }
}
