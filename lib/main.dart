import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/great_places.dart';
import './helpers/custom_page_route.dart';
import './screens/place_list_screen.dart';
import './screens/add_place_screen.dart';
import './screens/map_screen.dart';
import './screens/pick_location.dart';
import './screens/place_detail_screen.dart';
import './screens/Image_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
            TargetPlatform.iOS: CustomPageTransitionBuilder(),
          }),
          primarySwatch: Colors.indigo,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: Colors.indigo, secondary: Colors.amber),
        ),
        home: PlaceListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          MapScreen.routeName: (ctx) => MapScreen(),
          PickLocation.routeName: (ctx) => PickLocation(),
          DetailScreen.routeName: (ctx) => DetailScreen(),
          ImageScreen.routeName: (ctx) => ImageScreen(),
        },
      ),
    );
  }
}
