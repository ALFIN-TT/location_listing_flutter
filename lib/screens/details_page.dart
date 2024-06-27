import 'package:flutter/material.dart';
import 'package:flutter_assignment/data/models/detail_list_item.dart';
import 'package:flutter_assignment/data/models/location_response.dart';
import 'package:flutter_assignment/screens/widgets/common_app_bar.dart';
import 'package:flutter_assignment/utils/url_utils.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.location});

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
    List<DetailListItem> detailsMenu = _makeDetailsMenu(location);

    return Expanded(
        child: ListView.builder(
            itemCount: detailsMenu.length,
            itemBuilder: (context, index) {
              DetailListItem listItem = detailsMenu[index];
              return Column(children: [
                ListTile(
                    title: Text(
                      listItem.title,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      listItem.value,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: listItem.icon != null
                        ? Icon(listItem.icon)
                        : SizedBox.shrink(),
                    onTap: () {
                      _onMenuTap(listItem);
                    }),
                const Divider()
              ]);
            }));
  }

  _onMenuTap(DetailListItem menu) {
    switch (menu.type) {
      case MenuType.email:
        openEmail(menu.value);
      case MenuType.phone:
        openPhone(menu.value);
      case MenuType.location:
        {
          final geometry = menu.geometry;
          if (geometry != null) {
            try {
              openInMap(geometry.lat!, geometry.lng!);
            } catch (e) {}
          }
        }
      default:
        {}
    }
  }

  List<DetailListItem> _makeDetailsMenu(Location location) {
    List<DetailListItem> detailsMenu = [];

    detailsMenu.add(DetailListItem(
        title: 'TCS Center Name',
        value: '${location.location}',
        icon: Icons.home_work,
        type: MenuType.label));

    detailsMenu.add(DetailListItem(
        title: 'Location',
        value: '${location.geo} - ${location.area}',
        icon: Icons.location_on_outlined,
        type: MenuType.location,
        geometry: location.geometry));

    if (location.phone?.isNotEmpty == true) {
      detailsMenu.add(DetailListItem(
          title: 'Phone',
          value: location.phone!,
          icon: Icons.phone_enabled_outlined,
          type: MenuType.phone));
    }

    if (location.email?.isNotEmpty == true) {
      detailsMenu.add(DetailListItem(
          title: 'Email',
          value: location.email!,
          icon: Icons.email_outlined,
          type: MenuType.email));
    }

    if (location.address?.isNotEmpty == true) {
      detailsMenu.add(DetailListItem(
          title: 'Address', value: location.address!, type: MenuType.label));
    }

    detailsMenu.add(DetailListItem(
        title: 'Office Type',
        value: location.officeType?.firstOrNull ?? 'N/A',
        type: MenuType.label));

    return detailsMenu;
  }
}
