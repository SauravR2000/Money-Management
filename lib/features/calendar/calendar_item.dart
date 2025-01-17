import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  toFormat([String? newPattern, String? locale]) {
    return DateFormat(newPattern, locale).format(this);
  }

  String get dateDash => toFormat("yyyy-MM-dd");

  String get dateDashTime => toFormat("yyyy-MM-dd HH:mm");

  String get dateDashEEEE => toFormat("yyyy-MM-dd EEEE");

  String get monthName => toFormat("MMMM");

  String get calendarTitle => toFormat("MMMM yyyy");

  bool get isSaturday => weekday == 6;

  bool get isSunday => weekday == 7;

  bool get isToday {
    var today = DateTime.now();
    return year == today.year && month == today.month && day == today.day;
  }
}

class _WeekHeaders extends StatelessWidget {
  const _WeekHeaders({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
            .asMap()
            .entries
            .map(
              (entry) => Expanded(
                child: Text(
                  entry.value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _getTitleColor(entry.key), // entry.key is the index
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  _getTitleColor(int index) {
    if (index == 5) {
      return Colors.blueAccent;
    }

    if (index == 6) {
      return const Color(0xFFFF8181);
    }

    return const Color(0xAD1A1642);
  }
}

class CalendarBlock extends StatelessWidget {
  const CalendarBlock(
    this.month,
    this.cells,
    this.holidaysMap, {
    required this.today,
    this.header,
    this.isJapanese = true,
    super.key,
  });

  final DateTime today;
  final DateTime month;
  final List<DateTime> cells;
  final Map<String, String> holidaysMap;
  final Widget? header;
  final bool isJapanese;

  @override
  Widget build(BuildContext context) {
    var holidays = holidaysMap.keys.toList();
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Align(alignment: Alignment.center, child: header ?? const SizedBox()),
          const _WeekHeaders(),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 0.9,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemCount: cells.length,
            itemBuilder: (context, index) {
              var item = cells[index];
              var isToday = item.isToday;
              var isSameMonth = item.month == month.month;
              var isHoliday = holidays.contains(item.dateDash);

              Color? bgColor;
              Color? textColor;

              if (item.isSaturday) {
                textColor = Colors.blueAccent;
              }

              if (item.isSunday) {
                textColor = Colors.red;
              }

              if (item.isToday && isHoliday) {
                bgColor = Colors.red;
                textColor = Colors.white;
              } else if (isToday) {
                bgColor = Colors.blueAccent;
                textColor = Colors.white;
              } else if (isHoliday) {
                bgColor = const Color(0xFFFFEFEF);
                textColor = Colors.red;
              }

              return Card(
                color: bgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: isHoliday ? () {} : null,
                  borderRadius: BorderRadius.circular(10),
                  child: Opacity(
                    opacity: isSameMonth ? 1 : 0.3,
                    child:
                        //  Stack(
                        //   children: [
                        Center(
                      child: Text(
                        item.day.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: textColor),
                      ),
                    ),
                    //   ],
                    // ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
