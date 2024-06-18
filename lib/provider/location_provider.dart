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

  LocationResponse? get locations => _locations;

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  List<Location?>? get filteredLocations => _filteredLocations;

  Future loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _locations = await repository.getData();
      _filteredLocations = _locations?.locations;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  searchResults(String query) {
    _filteredLocations = locations?.locations?.where((item) => item!.location!.toLowerCase().contains(query.toLowerCase())).toList();
    notifyListeners();
  }
}
