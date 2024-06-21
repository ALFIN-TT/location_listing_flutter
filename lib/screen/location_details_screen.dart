import 'package:flutter/material.dart';
import 'package:flutter_assignment/data/models/location_response.dart';
import 'package:flutter_assignment/screen/widgets/common_app_bar.dart';
import 'package:flutter_assignment/util/util.dart';

class LocationDetailsPage extends StatelessWidget {
  const LocationDetailsPage({super.key, required this.location});

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CommonAppBar(title: "TCS Locator"),
        body: LocationDetailsPageBody(location: location));
  }
}

class LocationDetailsPageBody extends StatelessWidget {
  LocationDetailsPageBody({super.key, required this.location});

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            onTap: () {
              final geometry = location.geometry;
              if (geometry != null) {
                try {
                  openInMap(geometry.lat!, geometry.lng!);
                } catch (e) {}
              }
            }),
        if (location.phone?.isNotEmpty == true)
          ListTile(
              title: const Text('Phone'),
              subtitle: Text(location.phone!),
              trailing: const Icon(Icons.phone),
              onTap: () {
                openPhone(location.phone!);
              }),
        ListTile(
          title: const Text('Email'),
          subtitle: Text(location.email ?? 'N/A'),
          trailing: const Icon(Icons.email),
          onTap: () {
            openEmail(location.email!);
          },
        ),
        ListTile(
          title: Text('Address'),
          subtitle: Text(location.address ?? 'N/A'),
        ),
        ListTile(
          title: Text('Office Type'),
          subtitle: Text(location.officeType?.firstOrNull ?? 'N/A'),
        ),
      ],
    );
  }
}
