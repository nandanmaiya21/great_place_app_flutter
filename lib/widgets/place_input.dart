import 'package:flutter/material.dart';
import '../helpers/location_helper.dart';
import 'package:location/location.dart';
import '../screens/map_screen.dart';
import '../screens/pick_location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  LocationData? locData;
  Map<String, double>? result;
  Map<String, double>? _loc;

  Future<void> _getCurrentUserLocation() async {
    locData = await Location().getLocation();

    final staticMapImageUrl = LocationHelper.generateLocationPreViewImage(
        latitude: locData!.latitude, longitude: locData!.longitude);

    result = {
      'latitude': locData!.latitude!,
      'longitude': locData!.longitude!,
    };
    setState(() {
      _previewImageUrl = staticMapImageUrl;
      _loc = result;
      widget.onSelectPlace(_loc);
    });
  }

  void select() async {
    result = await Navigator.of(context).pushNamed(PickLocation.routeName)
        as Map<String, double>;

    final staticMapImageUrl = LocationHelper.generateLocationPreViewImage(
        latitude: result!['latitude'], longitude: result!['longitude']);
    // print(result);

    setState(() {
      _previewImageUrl = staticMapImageUrl;
      _loc = result;
      widget.onSelectPlace(_loc);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null
              ? Text(
                  'No Location Choosen',
                  textAlign: TextAlign.center,
                )
              : InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(MapScreen.routeName, arguments: _loc);
                  },
                  child: Image.network(
                    _previewImageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              style: TextButton.styleFrom(
                textStyle:
                    TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            TextButton.icon(
              onPressed: select,
              icon: Icon(Icons.map_sharp),
              label: Text('Select on Map'),
              style: TextButton.styleFrom(
                textStyle:
                    TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        )
      ],
    );
  }
}
