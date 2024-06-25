import 'package:flutter/foundation.dart';
import 'package:flutter_assignment/data/models/location_response.dart';
import 'package:flutter_assignment/data/repository/repository.dart';

const locationFilterAll = 'All';

class LocationProvider extends ChangeNotifier {
  final Repository repository;

  LocationProvider({required this.repository}) {
    _loadData();
  }

  LocationResponse? _locations;
  bool _isLoading = false;
  String _errorMessage = "";
  List<Location?>? _filteredLocations;
  List<String> _locationFilter = [];
  String _selectedFilter = locationFilterAll;
  String _searchQuery = "";

  LocationResponse? get locations => _locations;

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  List<Location?>? get filteredLocations => _filteredLocations;

  List<String>? get locationFilter => _locationFilter;

  String get selectedFilter => _selectedFilter;

  String get searchQuery => _searchQuery;

  ///* fetching data from network and saved to a list. Also this method generates locations list for filter operation.
  /// this function display location to ui
  ///
  Future _loadData() async {
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

  ///* generating location result after apply search query and filters based on user selection and search.
  ///
  fetchLocationsResult({String? query, String? filterItem}) {
    if (query != null) _searchQuery = query;
    if (filterItem != null) _selectedFilter = filterItem;
    if (_searchQuery.isNotEmpty) {
      //search query is not empty.
      if (selectedFilter == locationFilterAll) {
        //checking search filter is 'All' or not.
        //search filter is 'All'.
        _filteredLocations = _locations?.locations
            ?.where((item) => (item!.location!
                .toLowerCase()
                .contains(_searchQuery.toLowerCase())))
            .toList();
        //then no need to perform filter operation, then performing search only.
      } else {
        //search filter is not 'All' type.
        //so applying filter and search operations.
        _filteredLocations = _locations?.locations
            ?.where((item) => (item!.location!
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase()) &&
                (item.area == selectedFilter)))
            .toList();
      }
    } else {
      //search text is empty so no need to perform search operations.
      if (selectedFilter == locationFilterAll) {
        //checking search filter is 'All' or not.
        //here search filter is 'All' type then showing all location.
        _filteredLocations = _locations?.locations;
      } else {
        //here search filter is not 'All' type, then performing filter operation.
        _filteredLocations = _locations?.locations
            ?.where((item) => item?.area == selectedFilter)
            .toList();
      }
    }
    notifyListeners();
  }

  /// * generate and keep the the unique locations list for applying filter.
  ///
  _makeLocationFilter(List<Location?>? locations) {
    List<Location?>? _locations = [];
    _locations.addAll(locations!);
    if (_locations!.isNotEmpty) {
      final ids = _locations.map((location) => location?.area).toSet();
      _locations.retainWhere((x) => ids.remove(x?.area));
      List<String> filters = [locationFilterAll];
      for (var location in _locations) {
        filters.add(location?.area ?? '');
      }
      _locationFilter = filters;
    }
  }
}
