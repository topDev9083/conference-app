import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher_string.dart';

final _logger = Logger('url_launcher.dart');

Future<bool> launchUrl(
  final String url, {
  final LaunchMode mode = LaunchMode.platformDefault,
}) async {
  var updatedUrl = url;
  if (url.startsWith('data:')) {
    // do nothing
  } else if (!url.startsWith('http://') && !url.startsWith('https://')) {
    updatedUrl = 'http://$url';
  }
  try {
    if (await canLaunchUrlString(updatedUrl)) {
      return launchUrlString(
        updatedUrl,
        mode: mode,
      );
    } else {
      _logger.info('launchUrl: Cant launch');
    }
  } catch (e) {
    _logger.severe('launchUrl: $e');
  }
  return false;
}
