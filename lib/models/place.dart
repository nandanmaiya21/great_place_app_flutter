import 'dart:io';

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place(
      {required this.id,
      required this.title,
      required this.location,
      required this.image});
}

class PlaceLocation {
  final double latitude;
  final double logitude;
  final String? address;

  PlaceLocation({required this.latitude, required this.logitude, this.address});
}
