import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_place/models/place.dart';
import 'package:great_place/screens/Image_screen.dart';
import '../screens/map_screen.dart';
import '../helpers/location_helper.dart';

class DetailScreen extends StatelessWidget {
  static const String routeName = '/detail-screen';
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Place place = ModalRoute.of(context)!.settings.arguments as Place;

    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(MapScreen.routeName,
                      arguments: {
                        'latitude': place.location.latitude,
                        'longitude': place.location.logitude
                      });
                },
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: Image.network(
                      LocationHelper.generateLocationPreViewImage(
                          latitude: place.location.latitude,
                          longitude: place.location.logitude),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(place.location.address!),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => Navigator.of(context)
                    .pushNamed(ImageScreen.routeName, arguments: place.image),
                child: Container(
                  width: 250,
                  height: 250,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                          image: FileImage(place.image), fit: BoxFit.cover)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
