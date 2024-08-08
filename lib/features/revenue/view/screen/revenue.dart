import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class RevenueChart extends StatefulWidget {
  @override
  _RevenueChartState createState() => _RevenueChartState();
}

class _RevenueChartState extends State<RevenueChart> {
  DateTime? _startDate;
  DateTime? _endDate;
  List<RevenueData> _filteredData = [];
  int _selectedYear = DateTime.now().year;

  // Original data remains unchanged
  List<RevenueData> _allRevenueData = [
    RevenueData(DateTime(2024, 1, 1), 10000),
    RevenueData(DateTime(2024, 2, 1), 30000),
    RevenueData(DateTime(2024, 3, 1), 20000),
    RevenueData(DateTime(2024, 4, 1), 50000),
    RevenueData(DateTime(2024, 5, ), 40000),
    RevenueData(DateTime(2024, 6, 1), 45000),
    RevenueData(DateTime(2024, 7, 1), 30000),
    RevenueData(DateTime(2024, 8, 1), 20000),
    RevenueData(DateTime(2024, 9, 1), 40000),
    RevenueData(DateTime(2024, 10, 1), 50000),
    RevenueData(DateTime(2024, 11, 1), 45000),
    RevenueData(DateTime(2024, 12, 1), 60000),
  ];

  @override
  void initState() {
    super.initState();
    _filterDataForYear();
  }

  void _filterDataForYear() {
    setState(() {
      _filteredData = _allRevenueData
          .where((data) => data.date.year == _selectedYear)
          .toList();
    });
  }

  void _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime(2024, 12, 31),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
        _filteredData = _filteredData
            .where((data) =>
                data.date.isAfter(_startDate!.subtract(Duration(days: 1))) &&
                data.date.isBefore(_endDate!.add(Duration(days: 1))))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C3E50),
      appBar: AppBar(
        title: Text(
          'Revenue Chart',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF34495E),
        actions: [
          IconButton(
            icon: Icon(Icons.date_range, color: Colors.white),
            onPressed: _selectDateRange,
          ),
        ],
      ),
      body: Column(
        children: [
          if (_startDate != null && _endDate != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Selected range: ${DateFormat('MMM dd, yyyy').format(_startDate!)} - ${DateFormat('MMM dd, yyyy').format(_endDate!)}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Year: ',
                style: TextStyle(color: Colors.white),
              ),
              DropdownButton<int>(
                value: _selectedYear,
                dropdownColor: Color(0xFF34495E),
                items: List.generate(3, (index) {
                  int year = DateTime.now().year - 1 + index;
                  return DropdownMenuItem(
                    value: year,
                    child: Text(
                      '$year',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    _selectedYear = value!;
                    _filterDataForYear();
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 1000, // Adjust the width to make it scrollable
                  child: LineChart(
                    LineChartData(
                      backgroundColor: Color(0xFF34495E),
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 10000,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                '${value ~/ 1000}k',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              int month = value.toInt();
                              if (month < 1 || month > 12) return Container();
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding for spacing
                                child: Text(
                                  DateFormat('MMM').format(DateTime(_selectedYear, month)),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.white),
                      ),
                      minX: 1,
                      maxX: 12,
                      minY: 0,
                      maxY: 60000,
                      lineBarsData: [
                        LineChartBarData(
                          spots: _filteredData
                              .map((data) => FlSpot(data.date.month.toDouble(), data.amount.toDouble()))
                              .toList(),
                          isCurved: true,
                          color: Colors.white,
                          barWidth: 4,
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.white.withOpacity(0.3),
                          ),
                          dotData: FlDotData(show: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RevenueData {
  final DateTime date;
  final double amount;

  RevenueData(this.date, this.amount);
}
