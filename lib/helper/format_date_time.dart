import 'package:intl/intl.dart';

String formatDateTime({required DateTime createdAt}) {
  // Parse the timestamp to DateTime
  // DateTime dateTime = DateTime.parse(createdAt);

  // Define the desired format
  String formattedDate = DateFormat("EEEE d MMMM yyyy HH:mm").format(createdAt);

  return formattedDate;
}
