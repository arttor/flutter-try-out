import 'package:dflow/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:latlong/latlong.dart';
import 'package:redux/redux.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: StoreConnector<AppState, String>(
            onDidChange: (view) {
              if (view == null)
                Navigator.of(context).pushReplacementNamed("/login");
            },
            converter: (Store<AppState> store) => store.state.user?.username,
            builder: (_, name) => new Text(name ?? "")),
        actions: <Widget>[
          StoreConnector<AppState, VoidCallback>(
            converter: (s) {
              return () => s.dispatch(LogoutAction(User(null, null)));
            },
            builder: (context, callback) => IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: callback,
            ),
          ),
        ],
      ),
      body: new FlutterMap(
          options:
              new MapOptions(center: new LatLng(35.22, -101.83), minZoom: 10.0),
          layers: [
            new TileLayerOptions(
                urlTemplate: "https://api.tiles.mapbox.com/v4/"
                    "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                additionalOptions: {
                  'accessToken':
                      'pk.eyJ1IjoibWF0dGhld3RvcnkiLCJhIjoiY2pleDU3czl6MDI3YTJ6bms5ZnA0cWF1YyJ9.8_zTUzsIjhhucc2K0n-_Fg',
                  'id': 'mapbox.streets',
                })
          ]),
    );
  }
}
