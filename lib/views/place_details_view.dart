import 'package:flutter/material.dart';

import '../models/place_model.dart';

class PlaceDetailsView extends StatelessWidget {
  final Place place;

  PlaceDetailsView({required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${place.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Address: ${place.address}',
              style: TextStyle(fontSize: 16),
            ),
            // Você pode adicionar mais detalhes e comentários aqui
          ],
        ),
      ),
    );
  }
}
