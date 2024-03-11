import 'package:flutter_dotenv/flutter_dotenv.dart';

class _Config {
  final apiUrl = dotenv.env['API_URL'];
  final deepLink = dotenv.env['DEEP_LINK']!;
  final eventCode = dotenv.env['EVENT_CODE'];
  final defaultLanguageCode = 'en';
  final webPushCertificate =
      'BAmXulSZKwa7zZ3kJdDSEARLPoKM8qKreo7Rs2XoXtwOg5maMjU39T4j50Svhu2xItpu4Wbi0Yscxr7Ny6r712A';
}

final config = _Config();
