import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:intl/intl.dart';

final String TIME_PARAMETER = 'time';

void main() {
  var handler = const Pipeline().addMiddleware(logRequests())
      .addHandler(_echoRequest);

  serve(handler, 'localhost', 8080).then((server) {
    print('Serving at http://${server.address.host}:${server.port}');
  });
}

Response _echoRequest(Request request) {
  var now = new DateTime.now();

  Map<String, String> parameters = request.url.queryParameters;

  bool hasTime = false;
  if(parameters[TIME_PARAMETER] != null) {
    hasTime = parameters[TIME_PARAMETER].toLowerCase() == 'true';
  }

  var formatter = new DateFormat('dd-MM-yyyy');
  if(hasTime) {
    formatter = new DateFormat('dd-MM-yyyy - HH:mm:ss');
  }

  String formatted = formatter.format(now);
  return new Response.ok('Request at date: ${formatted}');
}

