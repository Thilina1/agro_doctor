import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyFormPage extends StatefulWidget {
  final String displayName;
  final String photoUrl;
  final String email;

  const MyFormPage(
      {Key? key,
      required this.displayName,
      required this.photoUrl,
      required this.email})
      : super(key: key);

  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> fetchDataFromFirestore() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: widget.displayName)
        .get();

    return snapshot;
  }

  void _saveForm() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;
      try {
        final name = formData['name'];
        final age = int.tryParse(formData['age'] ?? '');
        final occupation = formData['occupation'];
        final location = formData['location'];
        final mobileNum = formData['mobileNum'];
        final email = formData['email'];

        if (age != null) {
          await saveFormData(name, age, occupation, location, mobileNum, email);
          showSnackBar('Data saved successfully!');
        } else {
          throw const FormatException('Invalid age value');
        }
      } catch (error) {
        print('Error saving data: $error');
        showSnackBar('Failed to save data.');
      }
    }
  }

  Future<void> saveFormData(
    String name,
    int age,
    String occupation,
    String location,
    String mobileNum,
    String email,
  ) async {
    final collectionRef = _firestore.collection('users');
    await collectionRef.add({
      'name': name,
      'age': age,
      'occupation': occupation,
      'location': location,
      'mobileNum': mobileNum,
      'email': email
    });
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Edit Your Data',
          style: TextStyle(color: Colors.black),
        ),
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                Container(
                  height: 300, // Set a fixed height
                  child: FutureBuilder<QuerySnapshot>(
                    future: fetchDataFromFirestore(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasData) {
                        final documents = snapshot.data!.docs;
                        if (documents.isNotEmpty) {
                          return ListView.builder(
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              final datad = documents[index].data()
                                  as Map<String, dynamic>;
                              final named = datad['name'];
                              final aged = datad['age'];
                              final occupationd = datad['occupation'];
                              final locationd = datad['location'];
                              final mobileNumd = datad['mobileNum'];
                              final emaild = datad['email'];
                              return ListTile(
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            '$named',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: CircleAvatar(
                                              radius: 50,
                                              backgroundImage:
                                                  NetworkImage(widget.photoUrl),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: double.infinity,
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                const WidgetSpan(
                                                    child: Icon(
                                                        Icons.calendar_month)),
                                                TextSpan(text: 'Age: $aged'),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                const WidgetSpan(
                                                    child: Icon(Icons.man)),
                                                TextSpan(
                                                    text:
                                                        'Occupation: $occupationd'),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                const WidgetSpan(
                                                    child: Icon(
                                                        Icons.location_city)),
                                                TextSpan(
                                                    text:
                                                        'Location: $locationd'),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                const WidgetSpan(
                                                    child: Icon(Icons.call)),
                                                TextSpan(
                                                    text:
                                                        'mobileNum:$mobileNumd'),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                const WidgetSpan(
                                                    child: Icon(Icons.email)),
                                                TextSpan(text: 'Email:$emaild'),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return ListView(
                            children: [
                              Image.asset(
                                'images/icon/thinkfarmer.png',
                                height: 100.0,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Center(
                                child: Text(
                                  "No your data found Please enter your details.",
                                  style: TextStyle(fontSize: 17),
                                ),
                              )
                            ],
                          );
                        }
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error occurred: ${snapshot.error.toString()}',
                          ),
                        );
                      }

                      return const Center(
                        child: Text('No data found.'),
                      );
                    },
                  ),
                ),
                FormBuilderTextField(
                  name: 'name',
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: FormBuilderValidators.required(context),
                  enabled: false, // Disable editing
                  initialValue: widget.displayName, // Set the fixed value
                ),
                FormBuilderTextField(
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: FormBuilderValidators.required(context),
                  enabled: false, // Disable editing
                  initialValue: widget.email, // Set the fixed value
                ),
                FormBuilderTextField(
                  name: 'age',
                  decoration: const InputDecoration(labelText: 'Age'),
                  validator: FormBuilderValidators.required(context),
                ),
                FormBuilderTextField(
                  name: 'occupation',
                  decoration: const InputDecoration(labelText: 'Occupation'),
                  validator: FormBuilderValidators.required(context),
                ),
                FormBuilderTextField(
                  name: 'location',
                  decoration: const InputDecoration(labelText: 'Location'),
                  validator: FormBuilderValidators.required(context),
                ),
                FormBuilderTextField(
                  name: 'mobileNum',
                  decoration: const InputDecoration(labelText: 'Mobile Number'),
                  validator: FormBuilderValidators.required(context),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _saveForm,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FirestoreDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Data'),
      ),
      body: const Center(
        child: Text('Displaying Firestore Data'),
      ),
    );
  }
}

class FormBuilderValidators {
  static required(BuildContext context, {String? errorText}) {
    return (value) {
      if (value == null || value.toString().isEmpty) {
        return errorText ?? 'This field is required.';
      }
      return null;
    };
  }
}
