import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_spotz/providers/great_places.dart';
import 'package:tour_spotz/screens/place_details_screen.dart';
// import './providers//great_places.dart';
import './screens//places_list_screen.dart';
import './screens//add_place_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Tour Spotz',
        theme: ThemeData(
          primaryColor: Colors.indigo,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
        ),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => const AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
