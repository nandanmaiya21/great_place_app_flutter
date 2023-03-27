const MAPBOX_API_KEY =
    'pk.eyJ1IjoibmFuZGFubWFpeWEiLCJhIjoiY2xlbGs2YzdsMGM0OTNxczRvejV5NHpzcyJ9.itSarJktRI93pkNv9pm_TA';

class LocationHelper {
  static String generateLocationPreViewImage(
      {double? latitude,
      double? longitude,
      int width = 600,
      int height = 300}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/${width}x${height}?access_token=$MAPBOX_API_KEY';
    ;
  }

  //static Future<String> getPlaceAddress(double lat, double lng) async {}
}
