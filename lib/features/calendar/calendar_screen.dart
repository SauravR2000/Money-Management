import 'package:flutter/material.dart';
import 'package:money_management_app/features/calendar/calendar_item.dart';
import 'dart:developer';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  final DateTime _today = DateTime.now();
  final Map<int, List<DateTime>> _monthCellsMap = {};

  final List<String> _holidays = [];
  final Map<String, String> _holidaysMap = {};

  setHolidays() {
    // US United States / Public holidays (2024)
    _holidaysMap.addAll({
      "2025-01-01": "New Year's Day",
      "2025-01-15": "Martin Luther King Jr. Day",
      "2025-02-19": "Presidents' Day",
      "2025-05-27": "Memorial Day",
      "2025-06-19": "Juneteenth National Independence Day",
      "2025-07-04": "Independence Day",
      "2025-09-02": "Labor Day",
      "2025-10-14": "Columbus Day",
      "2025-11-11": "Veterans Day",
      "2025-11-28": "Thanksgiving Day",
      "2025-12-25": "Christmas Day",
    });
    _holidays.addAll(_holidaysMap.keys.toList());
  }

  @override
  void initState() {
    setHolidays();
    List.generate(12, (index) {
      // generateMonthCells(DateTime(_today.year, 0 + 1, 1));
      generateMonthCells(DateTime(_today.year, index + 1, 1));
    });
    super.initState();
  }

  generateMonthCells(DateTime month) async {
    List<DateTime> cells = [];
    var totalDaysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    log("total days in month = $totalDaysInMonth");

    var firstDayDt = DateTime(month.year, month.month, 1);
    log("first day dt = $firstDayDt");
    var previousMonthDt = firstDayDt.subtract(const Duration(days: 1));
    log("previous month dt = $previousMonthDt");
    var nextMonthDt = DateTime(month.year, month.month, totalDaysInMonth)
        .add(const Duration(days: 1));
    log("next month dt = $nextMonthDt");

    var firstDayOfWeek = firstDayDt.weekday;
    log("first day of week = $firstDayOfWeek");
    var previousMonthDays =
        DateUtils.getDaysInMonth(previousMonthDt.year, previousMonthDt.month);
    log("previous month day = $previousMonthDays");

    // previous month days
    var previousMonthCells = List.generate(
        firstDayOfWeek - 1,
        (index) => DateTime(previousMonthDt.year, previousMonthDt.month,
            previousMonthDays - index));
    log("previous month cells = $previousMonthCells");
    cells.addAll(previousMonthCells.reversed);
    log("cells = $cells");

    // current month days
    var currentMonthCells = List.generate(totalDaysInMonth,
        (index) => DateTime(month.year, month.month, index + 1));
    log("current month cells = $currentMonthCells");
    cells.addAll(currentMonthCells);
    log("after cells = $cells");

    // next month days
    var remainingCellCount = 35 - cells.length;
    log("remaining cell count = $remainingCellCount");
    if (cells.length > 35) {
      remainingCellCount = 42 - cells.length;
    }

    var nextMonthCells = List.generate(remainingCellCount,
        (index) => DateTime(nextMonthDt.year, nextMonthDt.month, index + 1));
    log("nextMonthCells = $nextMonthCells");
    cells.addAll(nextMonthCells);
    log("cells = $cells");
    _monthCellsMap[month.month] = cells;
    log("_monthCellsMap = $_monthCellsMap");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Yearly Calendar"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ...List.generate(12, (index) {
                var calendarMonth = DateTime(_today.year, index + 1, 1);
                var cells = _monthCellsMap[index + 1] ?? [];
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: CalendarBlock(
                    calendarMonth,
                    cells,
                    _holidaysMap,
                    today: _today,
                    isJapanese: true,
                    header: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        calendarMonth.calendarTitle,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
