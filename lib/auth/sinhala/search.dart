import 'package:agro_doctor/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Model class for storing search results
class SearchResult {
  final String name;
  final String description;
  final String moreDescription;
  final String image;

  SearchResult(this.name, this.description, this.moreDescription, this.image);
}

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  late Database _database;
  TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  void _initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'search.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE search (
            id INTEGER PRIMARY KEY,
            name TEXT,
            description TEXT,
            moreDescription TEXT,
            image TEXT
          )
        ''');

        // Add some initial data
        await db.rawInsert('''
          INSERT INTO search (name, description, moreDescription, image)
          VALUES ('Item 1', 'Description 1', 'More description 1', 'image1.jpg')
        ''');

        // ignore: avoid_print
        print('Database initialized');
      },
    );

    // Add additional data after initialization
    await _database.rawInsert('''
      INSERT INTO search (name, description, moreDescription, image)
      VALUES ('Item 4', 'Description 4', 'More description 4', 'image4.jpg')
    ''');
  }

  void _search() async {
    String query = _searchController.text;

    if (query.isEmpty) {
      return;
    }

    List<Map<String, dynamic>> results = await _database.rawQuery('''
      SELECT * FROM search
      WHERE name LIKE '%$query%' OR description LIKE '%$query%'
    ''');

    setState(() {
      _searchResults = results
          .map((result) => SearchResult(
                result['name'],
                result['description'],
                result['moreDescription'],
                result['image'],
              ))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Search Pests & Diseaces',
          style: TextStyle(color: Colors.black),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _search,
                ),
              ),
            ),
          ),
          Expanded(
            child: _searchResults.isNotEmpty
                ? ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_searchResults[index].name),
                        subtitle: Text(_searchResults[index].description),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchResultPage(
                                searchResult: _searchResults[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                : Center(
                    child: ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'images/icon/farmerSearch.png',
                          width: 200,
                        ),
                      ),
                      const Text(
                        "No Search Results Found",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          },
                          child: Image.asset(
                            "images/icon/background carddiago.png",
                          ),
                        ),
                      ),
                    ],
                  )),
          ),
        ],
      ),
    );
  }
}

class SearchResultPage extends StatelessWidget {
  final SearchResult searchResult;

  const SearchResultPage({super.key, required this.searchResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          searchResult.name,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              searchResult.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(searchResult.moreDescription),
            const SizedBox(height: 16),
            Image.asset(searchResult.image),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                child: Image.asset(
                  "images/icon/background carddiago.png",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
