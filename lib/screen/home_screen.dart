import 'package:flutter/material.dart';
import 'package:flutter_assignment/data/models/location_response.dart';
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
    final dataProvider = Provider.of<LocationProvider>(context);
    TextEditingController searchTextEditingController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title,
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.w500)),
          actions: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Image.asset('assets/images/tcs_logo.png',
                    fit: BoxFit.cover)),
          ],
        ),
        body: Center(
            child: dataProvider.isLoading
                ? CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.inversePrimary)
                : dataProvider.errorMessage.isNotEmpty
                    ? Text(dataProvider.errorMessage)
                    : dataProvider.locations != null
                        ? Padding(
                            padding: const EdgeInsets.only(right: 16, left: 16),
                            child: Column(children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  onChanged: (value) {
                                    dataProvider.searchResults(value);
                                  },
                                  controller: searchTextEditingController,
                                  decoration: const InputDecoration(
                                      hintText: "Search here...",
                                      prefixIcon: Icon(Icons.search),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25.0)))),
                                ),
                              ),
                              Expanded(
                                  child: ListView.builder(
                                      itemCount: dataProvider
                                          .filteredLocations?.length,
                                      itemBuilder: (context, index) {
                                        Location? location =
                                            (dataProvider.filteredLocations ??
                                                [])[index];
                                        print("$location");
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
                                            trailing: const Icon(Icons
                                                .keyboard_arrow_right_rounded),
                                          ),
                                          const Divider()
                                        ]);
                                      }))
                            ]))
                        : const Center(child: Text('No data found!'))));
  }
}
