import 'package:flutter/foundation.dart';
import '../models/place.dart';
import 'dart:io';
import 'package:geocoding/geocoding.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _item = [];

  List<Place> get items {
    return [..._item];
  }

  Future<String> addressName(Map<String, double> loc) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(loc['latitude']!, loc['longitude']!);

    return placemarks[0].toString().trimRight();
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
    Map<String, double> loc,
  ) async {
    addressName(loc);
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: PlaceLocation(
          latitude: loc['latitude']!,
          logitude: loc['longitude']!,
          address: await addressName(loc)),
    );
    _item.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.logitude,
      'address': newPlace.location.address!,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    print(dataList);
    _item = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            location: PlaceLocation(
                latitude: item['loc_lat'],
                logitude: item['loc_lng'],
                address: item['address']),
            image: File(
              item['image'],
            ),
          ),
        )
        .toList();
    //print(_item);
    notifyListeners();
  }
}
