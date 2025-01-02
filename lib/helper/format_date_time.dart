import 'package:intl/intl.dart';

String formatDateTime({required DateTime dateTime}) {
  // Parse the timestamp to DateTime
  // DateTime dateTime = DateTime.parse(createdAt);

  // Define the desired format
  String formattedDate = DateFormat("EEEE d MMMM yyyy HH:mm").format(dateTime);

  return formattedDate;
}

String formatTime({required DateTime dateTime}) {
  String formattedTime = DateFormat('hh:mm a').format(dateTime);

  return formattedTime;
}
