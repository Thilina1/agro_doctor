import 'package:flutter/material.dart';

enum AreaUnit { Hectares, Acres }

class Week {
  final String name;

  Week(this.name);
}

class Crop {
  final String name;
  final double nitrogen;
  final double phosphorus;
  final double potassium;
  final List<Week> weeks;

  Crop({
    required this.name,
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
    required this.weeks,
  });
}

class FertilizerCalculator extends StatefulWidget {
  @override
  _FertilizerCalculatorState createState() => _FertilizerCalculatorState();
}

class _FertilizerCalculatorState extends State<FertilizerCalculator> {
  TextEditingController areaController = TextEditingController();
  TextEditingController nitrogenController = TextEditingController();
  TextEditingController phosphorusController = TextEditingController();
  TextEditingController potassiumController = TextEditingController();

  AreaUnit selectedUnit = AreaUnit.Hectares;
  double conversionFactor = 1.0; // Conversion factor for area unit

  double mopContent = 0.6; // Potassium (K₂O) content in MOP

  double mopQuantity = 0.0;
  double sspQuantity = 0.0;
  double ureaQuantity = 0.0;

  Crop? selectedCrop;
  Week? selectedWeek;

  List<Crop> crops = [
    Crop(
      name: 'Carrot',
      nitrogen: 100.0,
      phosphorus: 50.0,
      potassium: 70.0,
      weeks: [
        Week('Week 1'),
        Week('Week 2'),
        Week('Week 3'),
      ],
    ),
    Crop(
      name: 'Tomato',
      nitrogen: 120.0,
      phosphorus: 40.0,
      potassium: 60.0,
      weeks: [
        Week('Week 1'),
        Week('Week 2'),
        Week('Week 3'),
      ],
    ),
    Crop(
      name: 'Cabbage',
      nitrogen: 80.0,
      phosphorus: 30.0,
      potassium: 50.0,
      weeks: [
        Week('Week 1'),
        Week('Week 2'),
        Week('Week 3'),
      ],
    ),
    Crop(
      name: 'Bean',
      nitrogen: 90.0,
      phosphorus: 45.0,
      potassium: 65.0,
      weeks: [
        Week('Week 1'),
        Week('Week 2'),
        Week('Week 3'),
      ],
    ),
    Crop(
      name: 'Beetroot',
      nitrogen: 110.0,
      phosphorus: 55.0,
      potassium: 75.0,
      weeks: [
        Week('Week 1'),
        Week('Week 2'),
        Week('Week 3'),
      ],
    ),
    Crop(
      name: 'Paddy',
      nitrogen: 120.0,
      phosphorus: 60.0,
      potassium: 50.0,
      weeks: [
        Week('At sowing'),
        Week('Week 4'),
        Week('Week 7'),
      ],
    ),
  ];

  void calculateFertilizerQuantities() {
    double area = double.parse(areaController.text) * conversionFactor;
    double nitrogenRequirement = selectedCrop?.nitrogen ?? 0.0;
    double phosphorusRequirement = selectedCrop?.phosphorus ?? 0.0;
    double potassiumRequirement = selectedCrop?.potassium ?? 0.0;

    // MOP calculation
    mopQuantity = (potassiumRequirement / mopContent) * area;

    // SSP calculation
    sspQuantity = (phosphorusRequirement / 0.16) * area;

    // Urea calculation
    ureaQuantity = (nitrogenRequirement / 0.46) * area;
  }

  @override
  void initState() {
    super.initState();
    selectedCrop = crops[0]; // Initialize with the first crop
    selectedWeek = selectedCrop
        ?.weeks[0]; // Initialize with the first week of the selected crop
    nitrogenController.text = selectedCrop?.nitrogen.toString() ?? '';
    phosphorusController.text = selectedCrop?.phosphorus.toString() ?? '';
    potassiumController.text = selectedCrop?.potassium.toString() ?? '';
  }

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
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: areaController,
                      decoration: const InputDecoration(
                        labelText: 'Area',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          calculateFertilizerQuantities();
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListTile(
                            title: const Text(
                              'Hectare',
                            ),
                            leading: Radio<AreaUnit>(
                              value: AreaUnit.Hectares,
                              groupValue: selectedUnit,
                              onChanged: (AreaUnit? value) {
                                setState(() {
                                  selectedUnit = value!;
                                  conversionFactor =
                                      1.0; // Hectares to Hectares
                                  calculateFertilizerQuantities();
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: const Text('Acres'),
                            leading: Radio<AreaUnit>(
                              value: AreaUnit.Acres,
                              groupValue: selectedUnit,
                              onChanged: (AreaUnit? value) {
                                setState(() {
                                  selectedUnit = value!;
                                  conversionFactor =
                                      2.47105; // Acres to Hectares
                                  calculateFertilizerQuantities();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DropdownButtonFormField<Crop>(
                      decoration: const InputDecoration(
                        labelText: 'Select Crop',
                      ),
                      value: selectedCrop,
                      items: crops.map((Crop crop) {
                        return DropdownMenuItem<Crop>(
                          value: crop,
                          child: Text(crop.name),
                        );
                      }).toList(),
                      onChanged: (Crop? crop) {
                        setState(() {
                          selectedCrop = crop;
                          selectedWeek = crop?.weeks[
                              0]; // Update the selected week to the first week of the selected crop
                          nitrogenController.text =
                              crop?.nitrogen.toString() ?? '';
                          phosphorusController.text =
                              crop?.phosphorus.toString() ?? '';
                          potassiumController.text =
                              crop?.potassium.toString() ?? '';
                          calculateFertilizerQuantities();
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
                    DropdownButtonFormField<Week>(
                      decoration: const InputDecoration(
                        labelText: 'Select Week',
                      ),
                      value: selectedWeek,
                      items: selectedCrop?.weeks.map((Week week) {
                        return DropdownMenuItem<Week>(
                          value: week,
                          child: Text(week.name),
                        );
                      }).toList(),
                      onChanged: (Week? week) {
                        setState(() {
                          selectedWeek = week;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: nitrogenController,
                      decoration: const InputDecoration(
                        labelText: 'Nitrogen Requirement',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          calculateFertilizerQuantities();
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: phosphorusController,
                      decoration: const InputDecoration(
                        labelText: 'Phosphorus Requirement',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          calculateFertilizerQuantities();
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: potassiumController,
                      decoration: const InputDecoration(
                        labelText: 'Potassium Requirement',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          calculateFertilizerQuantities();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Fertilizer Quantities',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'MOP (kg): $mopQuantity',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'SSP (kg): $sspQuantity',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Urea (kg): $ureaQuantity',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
