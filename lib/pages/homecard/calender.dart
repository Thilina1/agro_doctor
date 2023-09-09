import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _selectedDate;
  late Map<String, DateTime> _events;
  String? _selectedCrop;
  String? _selectedWeatherZone;
  String? _selectedDuration;
  String? _selectedSeason;

  late Map<String, List<String>> _cropEvents;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedCrop = 'Carrot';
    _selectedWeatherZone = null;
    _selectedDuration = null;
    _selectedSeason = null;

    _events = {
      'Pre-Seeding Stage': _selectedDate,
      'Event 2': _selectedDate,
      'Event 3': _selectedDate,
    };

    _cropEvents = {
      'Carrot': ['Pre-Seeding Stage', 'Event 2', 'Event 3'],
      'Papaya': ['Event 4', 'Event 5', 'Event 6'],
      'test': ['Event 8', 'Event 9', 'Event 10'],
    };
  }

  void _onDateSelected(DateTime date, DateTime? focusedDay) {
    setState(() {
      _selectedDate = date;
      _events['Pre-Seeding Stage'] = date.add(const Duration(days: 5));
      _events['Event 2'] = date.add(const Duration(days: 10));
      _events['Event 3'] = date.add(const Duration(days: 20));
      if (_selectedCrop == 'Papaya') {
        _events['Event 4'] = date.add(const Duration(days: 15));
        _events['Event 5'] = date.add(const Duration(days: 30));
        _events['Event 6'] = date.add(const Duration(days: 40));
      }
      if (_selectedCrop == 'test') {
        _events['Event 8'] = date.add(const Duration(days: 15));
        _events['Event 9'] = date.add(const Duration(days: 30));
        _events['Event 10'] = date.add(const Duration(days: 40));
      }
    });
  }

  void _showEventDetails(String eventName, DateTime eventDate) {
    String additionalInfo = '';

    if (eventName == 'Pre-Seeding Stage') {
      additionalInfo =
          'Additional info 1Additional info 1Additional info 1Additional info 1Additional info 1Additional info 1Additional info 1Additional info 1Additional info 1Additional info 1Additional info 1';
    } else if (eventName == 'Event 2') {
      additionalInfo = 'Additional info 2';
    } else if (eventName == 'Event 3') {
      additionalInfo = 'Additional info 3';
    } else if (eventName == 'Event 4') {
      additionalInfo = 'Additional info 4';
    } else if (eventName == 'Event 5') {
      additionalInfo = 'Additional info 5';
    } else if (eventName == 'Event 6') {
      additionalInfo = 'Additional info 6';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(eventName),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Date: ${eventDate.toString().substring(0, 10)}'),
              const SizedBox(height: 8),
              Text(additionalInfo),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToAnotherPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnotherPage(
          selectedCrop: _selectedCrop,
          selectedWeatherZone: _selectedWeatherZone,
          selectedDuration: _selectedDuration,
          selectedSeason: _selectedSeason,
        ),
      ),
    );
  }

  void _navigateToAnotherPage1() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnotherPage(
          selectedCrop: _selectedCrop,
          selectedWeatherZone: _selectedWeatherZone,
          selectedDuration: _selectedDuration,
          selectedSeason: _selectedSeason,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Calendar',
          style: TextStyle(color: Colors.black),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: _selectedCrop,
              items: [
                DropdownMenuItem<String>(
                  value: 'Carrot',
                  child: Text('Carrot'),
                ),
                DropdownMenuItem<String>(
                  value: 'Papaya',
                  child: Text('Papaya'),
                ),
                DropdownMenuItem<String>(
                  value: 'Test',
                  child: Text('Test'),
                ),
                DropdownMenuItem<String>(
                  value: 'Paddy',
                  child: Text('Paddy'),
                ),
              ],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedCrop = newValue;
                  });
                }
              },
            ),
          ),
          if (_selectedCrop == 'Paddy')
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DropdownButton<String>(
                    value: _selectedWeatherZone,
                    items: [
                      DropdownMenuItem<String>(
                        value: 'Dry & Intermediate Zone(Rainfed)',
                        child: Text('Dry & Intermediate Zone(Rainfed)'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Dry & Intermediate Zone (Irrigated)',
                        child: Text('Dry & Intermediate Zone (Irrigated)'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Wet Zone',
                        child: Text('Wet Zone'),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedWeatherZone = newValue;
                        });
                      }
                    },
                  ),
                  DropdownButton<String>(
                    value: _selectedDuration,
                    items: [
                      DropdownMenuItem<String>(
                        value: '2 1/2 months',
                        child: Text('2 1/2 months'),
                      ),
                      DropdownMenuItem<String>(
                        value: '3 months',
                        child: Text('3 months'),
                      ),
                      DropdownMenuItem<String>(
                        value: '3 1/2 months',
                        child: Text('3 1/2 months'),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedDuration = newValue;
                        });
                      }
                    },
                  ),
                  DropdownButton<String>(
                    value: _selectedSeason,
                    items: [
                      DropdownMenuItem<String>(
                        value: 'Maha',
                        child: Text('Maha'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Yala',
                        child: Text('Yala'),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedSeason = newValue;
                        });
                      }
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedCrop == 'Paddy' &&
                          _selectedWeatherZone == 'Wet Zone' &&
                          _selectedDuration == '2 1/2 months' &&
                          _selectedSeason == 'Maha') {
                        _navigateToAnotherPage();
                      }
                      if (_selectedCrop == 'Paddy' &&
                          _selectedWeatherZone == 'Wet Zone' &&
                          _selectedDuration == '2 1/2 months' &&
                          _selectedSeason == 'Yala') {
                        _navigateToAnotherPage1();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          Visibility(
            visible: _selectedCrop != 'Paddy' || _selectedCrop == null,
            child: TableCalendar(
              focusedDay: _selectedDate,
              firstDay: DateTime.utc(2021, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              selectedDayPredicate: (date) => isSameDay(date, _selectedDate),
              onDaySelected: _onDateSelected,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Sowing Date: ${_selectedDate.toString().substring(0, 10)}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          Visibility(
            visible:
                _selectedDate != DateTime(0, 0, 0) && _selectedCrop != null,
            child: Expanded(
              child: ListView.builder(
                itemCount: _cropEvents[_selectedCrop]?.length ?? 0,
                itemBuilder: (context, index) {
                  String eventName = _cropEvents[_selectedCrop]![index];
                  DateTime eventDate = _events[eventName]!;
                  String imagePath = '';

                  if (_selectedCrop == 'Paddy' &&
                      _selectedWeatherZone == 'Wet Zone' &&
                      _selectedDuration == '2 1/2 months' &&
                      _selectedSeason == 'Maha') {
                    imagePath = 'images/tipsIcon/1.png';
                  }

                  return Card(
                    child: ListTile(
                      title: Text(eventName),
                      subtitle: Text(eventDate.toString().substring(0, 10)),
                      tileColor: Colors.transparent,
                      onTap: () {
                        _showEventDetails(eventName, eventDate);
                      },
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnotherPage extends StatelessWidget {
  final String? selectedCrop;
  final String? selectedWeatherZone;
  final String? selectedDuration;
  final String? selectedSeason;

  const AnotherPage({
    required this.selectedCrop,
    required this.selectedWeatherZone,
    required this.selectedDuration,
    required this.selectedSeason,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Calendar',
          style: TextStyle(color: Colors.black),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 7,
            ),
            Text('Crop: $selectedCrop'),
            Text('Weather Zone: $selectedWeatherZone'),
            Text('Duration: $selectedDuration'),
            Text('Selected Season: $selectedSeason'),
            const SizedBox(
              height: 20,
            ),
            Image.asset("images/callendar/mahaWetPaddy.PNG")
          ],
        ),
      ),
    );
  }
}

class AnotherPage1 extends StatelessWidget {
  final String? selectedCrop;
  final String? selectedWeatherZone;
  final String? selectedDuration;
  final String? selectedSeason;

  const AnotherPage1({
    required this.selectedCrop,
    required this.selectedWeatherZone,
    required this.selectedDuration,
    required this.selectedSeason,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calender',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selected Crop: $selectedCrop'),
            Text('Selected Weather Zone: $selectedWeatherZone'),
            Text('Selected Duration: $selectedDuration'),
            Text('Selected Season: $selectedSeason'),
            Image.asset("images/callendar/yalaWetPaddy.PNG")
          ],
        ),
      ),
    );
  }
}
