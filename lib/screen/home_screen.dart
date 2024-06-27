import 'package:flutter/material.dart';
import 'package:flutter_assignment/data/models/location_response.dart';
import 'package:flutter_assignment/screen/location_details_screen.dart';
import 'package:flutter_assignment/screen/widgets/common_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/location_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => MyHomePageState(title);
}

class MyHomePageState extends State<MyHomePage> {
  MyHomePageState(this.title);

  final String title;
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: title), body: HomePageBody());
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<StatefulWidget> createState() => HomePageBodyState();
}

class HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
        builder: (context, dataProvider, child) => Center(
            child: dataProvider.isLoading
                ? CircularProgressIndicator()
                : dataProvider.errorMessage.isNotEmpty
                    ? Text(dataProvider.errorMessage)
                    : dataProvider.locations != null
                        ? Padding(
                            padding: const EdgeInsets.only(
                                right: 5, left: 5, top: 12, bottom: 12),
                            child: Column(children: [
                              SearchAndFilterRow(dataProvider: dataProvider),
                              if (dataProvider.filteredLocations?.isEmpty ==
                                  true)
                                const Expanded(
                                    child: Center(
                                  child: Text('No result found!'),
                                ))
                              else
                                LocationsList(dataProvider: dataProvider)
                            ]))
                        : const Center(child: Text('No data found!'))));
  }
}

class SearchAndFilterRow extends StatefulWidget {
  final LocationProvider dataProvider;

  const SearchAndFilterRow({required this.dataProvider, super.key});

  @override
  State<StatefulWidget> createState() =>
      SearchAndFilterRowState(dataProvider: dataProvider);
}

class SearchAndFilterRowState extends State<SearchAndFilterRow> {
  final LocationProvider dataProvider;

  SearchAndFilterRowState({required this.dataProvider});

  TextEditingController searchTextEditingController = TextEditingController();

  Future<void> _showFilters(
      BuildContext context, LocationProvider dataProvider) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SafeArea(
          child: ListView.builder(
              controller: scrollController,
              itemCount: dataProvider.locationFilter?.length,
              itemBuilder: (context, index) {
                final location = dataProvider.locationFilter?[index];
                return Column(children: [
                  ListTile(
                    trailing: dataProvider.selectedFilter == location
                        ? const Icon(
                            Icons.check,
                            color: Colors.black,
                          )
                        : const SizedBox.shrink(),
                    title: Text(location ?? ""),
                    onTap: () {
                      dataProvider.fetchLocationsResult(filterItem: location);
                      Navigator.of(context).pop(index);
                    },
                  ),
                  const Divider()
                ]);
              }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: searchTextEditingController,
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 12, top: 12, right: 5, bottom: 12),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 2.0),
                  ),
                  hintText: 'Search here...'),
              onChanged: (query) {
                dataProvider.fetchLocationsResult(query: query);
              },
            ),
          ),
          TextButton(
            onPressed: () {
              dataProvider.fetchLocationsResult(filterItem: locationFilterAll);
            },
            style: TextButton.styleFrom(
                minimumSize: const Size(40, 40),
                tapTargetSize: MaterialTapTargetSize.padded,
                alignment: Alignment.center),
            child: const Text('All'),
          ),
          IconButton(
              icon: const Icon(Icons.filter_list_outlined),
              onPressed: () {
                _showFilters(context, dataProvider);
              }),
        ],
      ),
    );
  }
}

class LocationsList extends StatelessWidget {
  final LocationProvider dataProvider;

  const LocationsList({required this.dataProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: dataProvider.filteredLocations?.length,
            itemBuilder: (context, index) {
              Location? location =
                  (dataProvider.filteredLocations ?? [])[index];
              return Column(children: [
                ListTile(
                  title: Text(
                    location?.location ?? "",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    '${location?.geo} - ${location?.area}',
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500),
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LocationDetailsPage(location: location!)));
                  },
                ),
                const Divider()
              ]);
            }));
  }
}
