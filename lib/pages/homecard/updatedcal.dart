import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _selectedDate;
  late Map<String, DateTime> _events;
  late String _selectedCrop;
  late Map<String, List<String>> _cropEvents;
  String? _selectedWeatherZone;
  String? _selectedPeriod;

  final List<String> weatherZones = [
    'Dry & Intermediate Zone(Rainfed)',
    'Dry & Intermediate Zone (Irrigated)',
    'Wet Zone',
  ];

  final List<String> periods = ['2 1/2 months', '3 months', '3 1/2 months'];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedCrop = 'Carrot';

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

  Widget _buildWeatherZoneDropdown() {
    return DropdownButton<String>(
      value: _selectedWeatherZone,
      items: weatherZones
          .map((zone) => DropdownMenuItem<String>(
                value: zone,
                child: Text(zone),
              ))
          .toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedWeatherZone = newValue;
          });
        }
      },
    );
  }

  Widget _buildPeriodDropdown() {
    return DropdownButton<String>(
      value: _selectedPeriod,
      items: periods
          .map((period) => DropdownMenuItem<String>(
                value: period,
                child: Text(period),
              ))
          .toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedPeriod = newValue;
          });
        }
      },
    );
  }

  void _fetchDataFromFirestore() {
    // Fetch data from Firestore based on user selection
    // Replace this with your Firestore implementation
    //   Firestore.instance.collection('calendar').where('selectedCrop', isEqualTo: _selectedCrop).where('weatherZone', isEqualTo: _selectedWeatherZone).where('period', isEqualTo: _selectedPeriod).get();
    print('Fetching data from Firestore...');
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
              items: _cropEvents.keys
                  .map((crop) => DropdownMenuItem<String>(
                        value: crop,
                        child: Text(crop),
                      ))
                  .toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedCrop = newValue;
                    _selectedWeatherZone = null;
                    _selectedPeriod = null;
                  });
                }
              },
            ),
          ),
          if (_selectedCrop != 'Paddy')
            TableCalendar(
              focusedDay: _selectedDate,
              firstDay: DateTime.utc(2021, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              selectedDayPredicate: (date) => isSameDay(date, _selectedDate),
              onDaySelected: _onDateSelected,
            )
          else
            Column(
              children: [
                Text('Select Weather Zone:'),
                _buildWeatherZoneDropdown(),
                const SizedBox(height: 16),
                Text('Select Period:'),
                _buildPeriodDropdown(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _fetchDataFromFirestore();
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          const SizedBox(height: 16),
          Text(
            'Sowing Date: ${_selectedDate.toString().substring(0, 10)}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          if (_selectedCrop != 'Paddy')
            _selectedDate != null
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _cropEvents[_selectedCrop]?.length ?? 0,
                      itemBuilder: (context, index) {
                        String eventName = _cropEvents[_selectedCrop]![index];
                        DateTime eventDate = _events[eventName]!;
                        String imagePath = '';

                        if (eventName == 'Event 2') {
                          imagePath =
                              'assets/event2.jpg'; // Replace with your image path
                        } else if (eventName == 'Event 3') {
                          imagePath =
                              'assets/event3.jpg'; // Replace with your image path
                        }

                        return Card(
                          child: ListTile(
                            title: Text(eventName),
                            subtitle:
                                Text(eventDate.toString().substring(0, 10)),
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
                  )
                : const Text(
                    'Please select a start date',
                    style: TextStyle(fontSize: 18),
                  )
          else
            const SizedBox(), // Empty space when 'Paddy' is selected
        ],
      ),
    );
  }
}
