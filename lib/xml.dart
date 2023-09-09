import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

class MyAppxml extends StatelessWidget {
  const MyAppxml({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Predict(),
    );
  }
}

class Predict extends StatefulWidget {
  const Predict({Key? key}) : super(key: key);

  @override
  State<Predict> createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  List<Map<String, String>> _employees = [];

  void _loadData() async {
    final List<Map<String, String>> temporaryList = [];

    const employeeXml = '''
      <root>
        <grid_temp_earlywarnveg3_freeze>
          <crop_id>Beans</crop_id>
          <crop_photo>bean.jpg</crop_photo>
          <natreqty>350.00</natreqty>
          <monextot>231.26</monextot>
          <balance>118.74</balance>
          <gpicturename>safe_1.jpg</gpicturename>
          <price>Good Price</price>
          <selection>Better Selection</selection>
          <scale>4</scale>
        </grid_temp_earlywarnveg3_freeze>
        <grid_temp_earlywarnveg3_freeze>
          <crop_id>Bitter gourd</crop_id>
          <crop_photo>Bitter-Gourd.jpg</crop_photo>
          <natreqty>135.00</natreqty>
          <monextot>62.36</monextot>
          <balance>72.64</balance>
          <gpicturename>safe_1.jpg</gpicturename>
          <price>Good Price</price>
          <selection>Better Selection</selection>
          <scale>4</scale>
        </grid_temp_earlywarnveg3_freeze>
        <grid_temp_earlywarnveg3_freeze>
          <crop_id>Brinjal</crop_id>
          <crop_photo>brinjol.jpg</crop_photo>
          <natreqty>450.00</natreqty>
          <monextot>236.80</monextot>
          <balance>213.20</balance>
          <gpicturename>safe_1.jpg</gpicturename>
          <price>Good Price</price>
          <selection>Better Selection</selection>
          <scale>4</scale>
        </grid_temp_earlywarnveg3_freeze>
        <grid_temp_earlywarnveg3_freeze>
          <crop_id>Brinjal</crop_id>
          <crop_photo>brinjol.jpg</crop_photo>
          <natreqty>450.00</natreqty>
          <monextot>236.80</monextot>
          <balance>213.20</balance>
          <gpicturename>safe_1.jpg</gpicturename>
          <price>Good Price</price>
          <selection>Better Selection</selection>
          <scale>4</scale>
        </grid_temp_earlywarnveg3_freeze>
        <grid_temp_earlywarnveg3_freeze>
          <crop_id>Capsicum</crop_id>
          <crop_photo>capsicum.jpg</crop_photo>
          <natreqty>140.00</natreqty>
          <monextot>75.19</monextot>
          <balance>64.81</balance>
          <gpicturename>safe_1.jpg</gpicturename>
          <price>Good Price</price>
          <selection>Better Selection</selection>
          <scale>4</scale>
        </grid_temp_earlywarnveg3_freeze>
        <grid_temp_earlywarnveg3_freeze>
          <crop_id>Cucumber</crop_id>
          <crop_photo>cucumber.png</crop_photo>
          <natreqty>125.00</natreqty>
          <monextot>53.00</monextot>
          <balance>72.00</balance>
          <gpicturename>safe_1.jpg</gpicturename>
          <price>Good Price</price>
          <selection>Better Selection</selection>
          <scale>4</scale>
        </grid_temp_earlywarnveg3_freeze>
        <grid_temp_earlywarnveg3_freeze>
          <crop_id>Leeks</crop_id>
          <crop_photo>leeks.jpg</crop_photo>
          <natreqty>80.00</natreqty>
          <monextot>52.18</monextot>
          <balance>27.82</balance>
          <gpicturename>safe_1.jpg</gpicturename>
          <price>Good Price</price>
          <selection>Better Selection</selection>
          <scale>4</scale>
        </grid_temp_earlywarnveg3_freeze>
        <grid_temp_earlywarnveg3_freeze>
          <crop_id>Long Bean</crop_id>
          <crop_photo>long been.jpg</crop_photo>
          <natreqty>325.00</natreqty>
          <monextot>186.21</monextot>
          <balance>138.79</balance>
          <gpicturename>safe_1.jpg</gpicturename>
          <price>Good Price</price>
          <selection>Better Selection</selection>
          <scale>4</scale>
        </grid_temp_earlywarnveg3_freeze>
        <grid_temp_earlywarnveg3_freeze>
          <crop_id>Luffa</crop_id>
          <crop_photo>luffa.jpg</crop_photo>
          <natreqty>125.00</natreqty>
          <monextot>84.00</monextot>
          <balance>41.00</balance>
          <gpicturename>safe_1.jpg</gpicturename>
          <price>Good Price</price>
          <selection>Better Selection</selection>
          <scale>4</scale>
        </grid_temp_earlywarnveg3_freeze>
        <grid_temp_earlywarnveg3_freeze>
          <crop_id>Okra</crop_id>
          <crop_photo>okra.jpg</crop_photo>
          <natreqty>250.00</natreqty>
          <monextot>178.92</monextot>
          <balance>71.08</balance>
          <gpicturename>safe_1.jpg</gpicturename>
          <price>Good Price</price>
          <selection>Better Selection</selection>
          <scale>4</scale>
        </grid_temp_earlywarnveg3_freeze>
        <grid_temp_earlywarnveg3_freeze>
          <crop_id>Pumpkin</crop_id>
          <crop_photo>pumkin.jpg</crop_photo>
          <natreqty>275.00</natreqty>
          <monextot>182.95</monextot>
          <balance>92.05</balance>
          <gpicturename>safe_1.jpg</gpicturename>
          <price>Good Price</price>
          <selection>Better Selection</selection>
          <scale>4</scale>
        </grid_temp_earlywarnveg3_freeze>
        <grid_temp_earlywarnveg3_freeze>
          <crop_id>Raddish</crop_id>
          <crop_photo>Raddish.jpg</crop_photo>
          <natreqty>100.00</natreqty>
          <monextot>79.86</monextot>
          <balance>20.14</balance>
          <gpicturename>safe_1.jpg</gpicturename>
          <price>Good Price</price>
          <selection>Better Selection</selection>
          <scale>4</scale>
        </grid_temp_earlywarnveg3_freeze>
        <grid_temp_earlywarnveg3_freeze>
          <crop_id>Snake gourd</crop_id>
          <crop_photo>sg.jpeg</crop_photo>
          <natreqty>140.00</natreqty>
          <monextot>73.51</monextot>
          <balance>66.49</balance>
          <gpicturename>safe_1.jpg</gpicturename>
          <price>Good Price</price>
          <selection>Better Selection</selection>
          <scale>4</scale>
        </grid_temp_earlywarnveg3_freeze>
        <grid_temp_earlywarnveg3_freeze>
          <crop_id>Tomato</crop_id>
          <crop_photo>Tomato.jpg</crop_photo>
          <natreqty>215.00</natreqty>
          <monextot>165.56</monextot>
          <balance>49.44</balance>
          <gpicturename>safe_1.jpg</gpicturename>
          <price>Good Price</price>
          <selection>Better Selection</selection>
          <scale>4</scale>
        </grid_temp_earlywarnveg3_freeze>
        <grid_temp_earlywarnveg3_freeze>
          <crop_id>Cabbage</crop_id>
          <crop_photo>cabbege.jpg</crop_photo>
          <natreqty>175.00</natreqty>
          <monextot>152.48</monextot>
          <balance>22.52</balance>
          <gpicturename>normal_2.jpg</gpicturename>
          <price>General Price</price>
          <selection>Good Selection</selection>
          <scale>3</scale>
        </grid_temp_earlywarnveg3_freeze>
        <grid_temp_earlywarnveg3_freeze>
          <crop_id>Carrot</crop_id>
          <crop_photo>carrot.jpg</crop_photo>
          <natreqty>125.00</natreqty>
          <monextot>106.00</monextot>
          <balance>19.00</balance>
          <gpicturename>normal_2.jpg</gpicturename>
          <price>General Price</price>
          <selection>Good Selection</selection>
          <scale>3</scale>
        </grid_temp_earlywarnveg3_freeze>
        <grid_temp_earlywarnveg3_freeze>
          <crop_id>Beet Roots</crop_id>
          <crop_photo>beet.jpg</crop_photo>
          <natreqty>100.00</natreqty>
          <monextot>121.96</monextot>
          <balance>_21.96</balance>
          <gpicturename>marginal_1.jpg</gpicturename>
          <price>Low Price </price>
          <selection>Poor Selection</selection>
          <scale>2</scale>
        </grid_temp_earlywarnveg3_freeze>
      </root>
    ''';

    // Parse XML data
    final document = xml.XmlDocument.parse(employeeXml);
    final employees =
        document.findAllElements('grid_temp_earlywarnveg3_freeze');
    for (final employee in employees) {
      final name = employee.findElements('crop_id').first.text;
      final salary = employee.findElements('price').first.text;
      final selection = employee.findElements('selection').first.text;
      temporaryList
          .add({'name': name, 'salary': salary, 'selection': selection});
    }

    setState(() {
      _employees = temporaryList;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recommended crops for cultivation',
          style: TextStyle(color: Colors.black),
        ),
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (index == 0) {
              // Add text as the first item in the list
              return const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Source information: Department of Agriculture',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                          "Recommendation to grow crops from 2023-07-17 to 2023-08-01"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              );
            }

            final salary = _employees[index - 1]['salary'];
            Color cardColor;

            if (salary == 'Good Price') {
              cardColor = Color.fromARGB(255, 161, 224, 163);
            } else if (salary == 'General Price') {
              cardColor = Colors.yellow;
            } else if (salary == 'General Price') {
              cardColor = Colors.amber.shade100;
            } else {
              cardColor = Color.fromARGB(255, 196, 109, 102);
            }

            return Card(
              key: ValueKey(_employees[index - 1]['name']),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              color: cardColor,
              elevation: 4,
              child: ListTile(
                title: Text(_employees[index - 1]['name']!),
                subtitle: Text(salary!),
              ),
            );
          },
          itemCount: _employees.length + 1,
        ),
      ),
    );
  }
}
