import 'package:dflow/screens/home/map_model.dart';
import 'package:dflow/screens/login/login_scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//  static LatLng london = new LatLng(51.5, -0.09);
//  static LatLng paris = new LatLng(48.8566, 2.3522);
//  static LatLng dublin = new LatLng(53.3498, -6.2603);

  MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = new MapController();
  }

  @override
  Widget build(BuildContext context) {
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
      body: ScopedModelDescendant<MapScopedModel>(
          builder: (context, child, model) => new FlutterMap(
                  mapController: mapController,
                  options: new MapOptions(
                      center: model.currLoc ?? LatLng(35.22, -101.83)),
                  layers: [
                    new TileLayerOptions(
                        urlTemplate: "https://api.tiles.mapbox.com/v4/"
                            "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                        additionalOptions: {
                          'accessToken':
                              'pk.eyJ1IjoibWF0dGhld3RvcnkiLCJhIjoiY2pleDU3czl6MDI3YTJ6bms5ZnA0cWF1YyJ9.8_zTUzsIjhhucc2K0n-_Fg',
                          'id': 'mapbox.streets',
                        }),
                    new MarkerLayerOptions(markers:
                      model.stations.map((s)=>new Marker(
                          width: 45.0,
                          height: 45.0,
                          point: s,
                          builder: (context) => new Container(
                            child: IconButton(
                              icon: Icon(Icons.local_gas_station),
                              color: Colors.red,
                              iconSize: 45.0,
                              onPressed: () {
                                print('Marker tapped');
                              },
                            ),
                          ))).followedBy(<LatLng>[model.currLoc].where((s)=>s!=null).map((s)=>new Marker(
                          width: 45.0,
                          height: 45.0,
                          point: s,
                          builder: (context) => new Container(
                            child: IconButton(
                              icon: Icon(Icons.directions_car),
                              color: Colors.blue,
                              iconSize: 45.0,
                              onPressed: () {
                                print('Marker tapped');
                              },
                            ),
                          )))).toList()

                    )
                  ])),
    );
  }
}
