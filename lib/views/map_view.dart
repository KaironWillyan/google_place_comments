import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/map_controller.dart';
import '../models/place_model.dart';
import 'place_details_view.dart';  // Certifique-se de importar o PlaceDetailsView aqui


class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? mapController;
  final MapController _mapController = MapController();
  Set<Marker> _markers = {};
  LatLng _currentLocation = LatLng(-15.7942, -47.8822); // Coordenadas de Brasília como exemplo

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    // Aqui você usaria o geolocator para obter a localização real do usuário
    final places = await _mapController.getNearbyPlaces(_currentLocation.latitude, _currentLocation.longitude);
    setState(() {
      _markers = places.map((place) {
        return Marker(
          markerId: MarkerId(place.name),
          position: LatLng(place.lat, place.lng),
          infoWindow: InfoWindow(
            title: place.name,
            snippet: place.address,
            onTap: () {
              _showPlaceDetails(place);
            },
          ),
        );
      }).toSet();
    });
  }

 void _showPlaceDetails(Place place) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlaceDetailsView(place: place)), // Certifique-se de que PlaceDetailsView está referenciado corretamente
    );
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nearby Places")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _currentLocation, zoom: 14.0),
        markers: _markers,
        onMapCreated: (controller) {
          mapController = controller;
        },
      ),
    );
  }
}