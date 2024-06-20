import 'package:flutter/foundation.dart';
import 'package:flutter_assignment/data/models/location_response.dart';
import 'package:flutter_assignment/data/repository/repository.dart';

class LocationProvider extends ChangeNotifier {
  final Repository repository;

  LocationProvider({required this.repository}) {
    loadData();
  }

  LocationResponse? _locations;
  bool _isLoading = false;
  String _errorMessage = "";
  List<Location?>? _filteredLocations;
  List<LocationFilter> _locationFilter = [];
  LocationFilter _selectedFilter =
      LocationFilter(name: "All", isSelected: true);

  LocationResponse? get locations => _locations;

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  List<Location?>? get filteredLocations => _filteredLocations;

  List<LocationFilter>? get locationFilter => _locationFilter;

  LocationFilter get selectedFilter => _selectedFilter;

  Future loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _locations = await repository.getData();
      _filteredLocations = _locations?.locations;
      _makeLocationFilter(_filteredLocations);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  searchResults(String query) {
    if (query.isNotEmpty) {
      _filteredLocations = _locations?.locations
          ?.where((item) =>
              item!.location!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      _filteredLocations = _locations?.locations;
    }
    notifyListeners();
  }

  applyFilter(LocationFilter filterItem) {
    _selectedFilter = filterItem;
    _filteredLocations =
        _filteredLocations?.where((i) => i?.area == filterItem.name).toList();
  }

  _makeLocationFilter(List<Location?>? locations) {
    List<Location?>? _locations = [];
    _locations.addAll(locations!);
    print("locations: $_locations");
    if (_locations!.isNotEmpty) {
      final ids = _locations.map((location) => location?.area).toSet();
      _locations.retainWhere((x) => ids.remove(x?.area));
      List<LocationFilter> filters = [LocationFilter(name: 'All')];
      for (var location in _locations) {
        filters.add(LocationFilter(name: location?.area));
      }
      _locationFilter = filters;
      print("filters: ${filters.toString()}");
    }
  }
}
