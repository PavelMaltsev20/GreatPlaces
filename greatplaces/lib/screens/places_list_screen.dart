import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

import 'add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your places list",
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlacesProvider>(
          context,
          listen: false,
        ).fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlacesProvider>(
                child: Center(
                  child: Text("Got no places yet, start adding some!"),
                ),
                builder: (ctx, greatPlaces, child) =>
                    greatPlaces.items.length <= 0
                        ? child
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (ctx, index) {
                              final currentPlace = greatPlaces.items[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(currentPlace.image),
                                ),
                                title: Text(currentPlace.title),
                                subtitle: Text(currentPlace.location.address),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      PlaceDetailsScreen.routeName,
                                      arguments: currentPlace.id);
                                },
                                onLongPress: () {
                                  Provider.of<GreatPlacesProvider>(context,
                                          listen: false)
                                      .deletePlace(currentPlace.id);
                                },
                              );
                            },
                          ),
              ),
      ),
    );
  }
}
