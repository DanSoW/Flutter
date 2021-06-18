import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class LocationDetails{
  String name = "";
  String type = "";
  String dimension = "";
  String created = "";
}

Future<LocationDetails> loadLocation(int id) async {
  var response = await http.get(Uri.parse(
      "https://rickandmortyapi.com/api/location/$id"
  ));

  LocationDetails location;

  var item = convert.jsonDecode(response.body);
  location = LocationDetails();
  location.name = item["name"];
  location.type = item["type"];
  location.dimension = item["dimension"];
  location.created = item["created"];

  print(location.name);
  return location;
}