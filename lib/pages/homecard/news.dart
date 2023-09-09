import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HighlightNews {
  final String topic;
  final String id;
  final String note;
  final String collectionName;
  final String stDiscription;
  final String image;
  final String Time;

  HighlightNews({
    required this.topic,
    required this.id,
    required this.note,
    required this.collectionName,
    required this.stDiscription,
    required this.image,
    required this.Time,
  });
}

class HighlightNewsScreen extends StatefulWidget {
  @override
  _HighlightNewsScreenState createState() => _HighlightNewsScreenState();
}

class _HighlightNewsScreenState extends State<HighlightNewsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<List<HighlightNews>> _highlightNewsFuture;

  @override
  void initState() {
    super.initState();
    _highlightNewsFuture = getHighlightNews();
  }

  Future<List<HighlightNews>> getHighlightNews() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('highlightNews').get();

      final List<HighlightNews> highlightNewsList = snapshot.docs.map((doc) {
        final data = doc.data();
        return HighlightNews(
          topic: data['Topic'] as String? ?? '',
          id: data['id'].toString(),
          note: data['note'] as String? ?? '',
          collectionName: data['collectionName'] as String? ?? '',
          stDiscription: data['stDiscription'] as String? ?? '',
          image: data['image'] as String? ?? '',
          Time: data['Time'] as String? ?? '',
        );
      }).toList();

      return highlightNewsList;
    } catch (e) {
      print('Error fetching highlightNews: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: FutureBuilder<List<HighlightNews>>(
        future: _highlightNewsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final List<HighlightNews>? highlightNewsList = snapshot.data;

            if (highlightNewsList != null && highlightNewsList.isNotEmpty) {
              return ListView.builder(
                itemCount: highlightNewsList.length,
                itemBuilder: (context, index) {
                  final HighlightNews highlightNews = highlightNewsList[index];

                  return Column(
                    children: [
                      Card(
                          margin: EdgeInsets.all(15),
                          child: GestureDetector(
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, right: 4),
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            highlightNews.topic,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          CachedNetworkImage(
                                            imageUrl: highlightNews.image,
                                            width: 500,
                                          ),
                                          Text(
                                            highlightNews.Time,
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                          Text(
                                            highlightNews.stDiscription,
                                            style:
                                                const TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetailScreen(
                                    topic: highlightNews.topic,
                                    description: highlightNews.note,
                                    collectionName:
                                        highlightNews.collectionName,
                                    image: highlightNews.image,
                                    Time: highlightNews.Time,
                                  ),
                                ),
                              );
                            },
                          )),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No news available.'),
              );
            }
          }
        },
      ),
    );
  }
}

String displayimage = 'document';

class NewsDetailScreen extends StatelessWidget {
  final String topic;
  final String description;
  final String collectionName;
  final String image;
  final String Time;

  const NewsDetailScreen(
      {super.key,
      required this.topic,
      required this.description,
      required this.collectionName,
      required this.image,
      required this.Time});

  @override
  Widget build(BuildContext context) {
    final String s = image;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'News',
          style: TextStyle(color: Colors.black),
        ),
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView(children: [
        const SizedBox(
          height: 8,
        ),
        Text(
          topic,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          Time,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        CachedNetworkImage(
          imageUrl: s,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        const SizedBox(height: 25),
        Text(
          '$description',
          style: const TextStyle(fontSize: 18),
        ),
      ]),
    );
  }
}
