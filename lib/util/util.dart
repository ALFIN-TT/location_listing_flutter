import 'package:url_launcher/url_launcher.dart';

void openPhone(String phoneNo) async {
  Uri phoneNoUri = Uri.parse('tel:$phoneNo');
  if (await launchUrl(phoneNoUri)) {
  } else {
    //error
  }
}

void openEmail(String email) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
  );

  if (await launchUrl(emailUri)) {
  } else {
    //error
  }
}

void openInMap(double lat, double lon) async {
  final url =
      Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon');
  if (await launchUrl(url)) {
  } else {
    throw Exception('Could not launch $url');
  }
}


