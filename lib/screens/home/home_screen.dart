import 'package:dflow/screens/login/login_scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: ScopedModelDescendant<LoginScopedModel>(
            builder: (context, child, model) => new Text(model.username ?? "")),
        actions: <Widget>[
          ScopedModelDescendant<LoginScopedModel>(
            builder: (context, child, model) => IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () {
                    model.logout();
                    Navigator.of(context).pushReplacementNamed("/login");
                  },
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
