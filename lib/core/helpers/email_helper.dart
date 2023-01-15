import 'package:url_launcher/url_launcher.dart';

Future<void> launchAnyUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}

final Uri emailLaunchUri = Uri(
  scheme: 'mailto',
  path: 'contact@topincitycatering.com',
);
