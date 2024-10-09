import 'package:cloudinary_url_gen/cloudinary.dart';

String userkey = 'dchjadopc';
String apiKey = '516484684576488';
String apiSecret = 'JToZcIBE1Q-O0OFMKhBYyPLDevE';

var cloudinary = Cloudinary.fromStringUrl(
    'cloudinary://<${apiKey}>:<${apiSecret}>@<${userkey}>');
