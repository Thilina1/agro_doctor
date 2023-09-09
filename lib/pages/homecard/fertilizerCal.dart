import 'package:flutter/material.dart';

class FCalculator extends StatefulWidget {
  const FCalculator({Key? key}) : super(key: key);

  @override
  State<FCalculator> createState() => _FCalculatorState();
}

class _FCalculatorState extends State<FCalculator> {
  int _selectedUnit = 0;

  String selectedVegetable = 'Carrot';
  List<String> vegetables = [
    'Carrot',
    'Broccoli',
    'Tomato',
    'Cucumber',
    'Spinach',
  ];

  int _number1 = 5;
  int _number2 = 10;
  int _number3 = 15;
  double _plotCount = 1.0;

  int _defaultNumber1 = 5;
  int _defaultNumber2 = 10;
  int _defaultNumber3 = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Fertilizer Calculator',
          style: TextStyle(color: Colors.black),
        ),
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          DropdownButton<String>(
            value: selectedVegetable,
            hint: const Text('Select a vegetable'),
            onChanged: (String? newValue) {
              setState(() {
                selectedVegetable = newValue!;
              });
            },
            items: vegetables.map((String vegetable) {
              return DropdownMenuItem<String>(
                value: vegetable,
                child: Text(vegetable),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          const Text(
            "Unit",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Flexible(
                child: RadioListTile(
                  title: const Text('Option 1'),
                  value: 0,
                  groupValue: _selectedUnit,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedUnit = value!;
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile(
                  title: const Text('Acre'),
                  value: 1,
                  groupValue: _selectedUnit,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedUnit = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Nutrient quantities",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildEditableCard(
                  " Nitrogen (N)",
                  _number1,
                  () => _showEditDialog((newValue) {
                    setState(() {
                      _number1 = newValue;
                    });
                  }),
                  () {
                    setState(() {
                      _number1 = _defaultNumber1;
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildEditableCard(
                  "Phosphorus (P)",
                  _number2,
                  () => _showEditDialog((newValue) {
                    setState(() {
                      _number2 = newValue;
                    });
                  }),
                  () {
                    setState(() {
                      _number2 = _defaultNumber2;
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildEditableCard(
                  "Potassium (K)",
                  _number3,
                  () => _showEditDialog((newValue) {
                    setState(() {
                      _number3 = newValue;
                    });
                  }),
                  () {
                    setState(() {
                      _number3 = _defaultNumber3;
                    });
                  },
                ),
              ),
            ],
          ),
          const Text(
            "Plot size",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    _plotCount -= 0.5;
                  });
                },
              ),
              Text(
                _plotCount.toString(),
                style: const TextStyle(fontSize: 24),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    _plotCount += 0.5;
                  });
                },
              ),
            ],
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Button action goes here
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              child: const Text('Calculate'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableCard(
    String title,
    int number,
    VoidCallback onPressed,
    VoidCallback onReset,
  ) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                number.toString(),
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 5),
              TextButton(
                onPressed: onReset,
                child: const Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showEditDialog(Function(int) onSave) async {
    int? newValue = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        int? updatedValue;

        return AlertDialog(
          title: const Text('Edit Number'),
          content: TextFormField(
            keyboardType: TextInputType.number,
            initialValue: '',
            onChanged: (value) {
              updatedValue = int.tryParse(value);
            },
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                Navigator.of(context).pop(updatedValue);
              },
            ),
          ],
        );
      },
    );

    if (newValue != null) {
      onSave(newValue);
    }
  }
}
