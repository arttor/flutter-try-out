import 'package:flutter/widgets.dart';
import 'package:latlong/latlong.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MapScopedModel extends Model {
  bool _isInit = false;
  Location _location = new Location();
  bool _permission;
  LatLng currLoc;
  List<LatLng> stations = [];
  List<LatLng> route = [];

  static MapScopedModel of(BuildContext context) =>
      ScopedModel.of<MapScopedModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    // update data for every subscriber, especially for the first one
    if (!_isInit) {
      _isInit = true;
      _init();
    }
  }

  buildRoute(LatLng to){
    route = [currLoc,to];
    notifyListeners();
  }

  _init() async {
    try {
      _permission = await _location.hasPermission();
      currLoc = await _location
          .getLocation()
          .then((val) => LatLng(val["latitude"], val["longitude"]));
      if(currLoc!=null){
        stations.add(LatLng(currLoc.latitude+0.05, currLoc.longitude+0.05));
        stations.add(LatLng(currLoc.latitude-0.05, currLoc.longitude-0.05));
        stations.add(LatLng(currLoc.latitude-0.05, currLoc.longitude+0.05));
        stations.add(LatLng(currLoc.latitude+0.05, currLoc.longitude-0.05));
      }
      notifyListeners();
    } on PlatformException catch (e) {}

    _location.onLocationChanged().listen((Map<String, double> curr) {
      currLoc = LatLng(curr["latitude"], curr["longitude"]);
      notifyListeners();
    });
  }
}
