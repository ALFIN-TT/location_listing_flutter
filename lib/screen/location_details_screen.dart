import 'package:flutter/material.dart';
import 'package:flutter_assignment/data/models/location_response.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationDetailsPage extends StatelessWidget {
  const LocationDetailsPage({super.key, required this.location});

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("TCS Locator",
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.w500)),
          actions: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Image.asset('assets/images/tcs_logo.png',
                    fit: BoxFit.cover))
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: const Text('TCS Center Name'),
              subtitle: Text(location.location ?? ''),
              trailing: const Icon(Icons.home_work_outlined),
            ),
            ListTile(
              title: const Text('Location'),
              subtitle: Text(
                '${location.geo} - ${location.area}',
              ),
              trailing: const Icon(Icons.location_pin),
            ),
            ListTile(
              title: Text('Phone'),
              subtitle: Text(location.phone ?? ''),
              trailing: Icon(Icons.phone),
            ),
            ListTile(
              title: Text('Email'),
              subtitle: Text(location.email ?? ''),
              trailing: Icon(Icons.email),
            ),
            ListTile(
              title: Text('Address'),
              subtitle: Text(location.address ?? ''),
            ),
            ListTile(
              title: Text('Office Type'),
              subtitle: Text(location.officeType?.firstOrNull ?? ''),
            ),
          ],
        ));
  }
}
