import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteListPage extends StatefulWidget {
  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  late Database _database;
  late List<Map<String, dynamic>> _notes;

  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }

  void initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, content TEXT NOT NULL)',
        );
      },
      version: 1,
    );
    fetchNotes();
  }

  void fetchNotes() async {
    final List<Map<String, dynamic>> notes = await _database.query('notes');
    setState(() {
      _notes = notes;
    });
  }

  void addNote() async {
    await _database.insert(
      'notes',
      {'title': 'New Note', 'content': 'Enter note content here'},
    );
    fetchNotes();
  }

  void updateNote(int id, String newTitle, String newContent) async {
    await _database.update(
      'notes',
      {'title': newTitle, 'content': newContent},
      where: 'id = ?',
      whereArgs: [id],
    );
    fetchNotes();
  }

  void deleteNote(int id) async {
    await _database.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Keep Notes',
          style: TextStyle(color: Colors.black),
        ),
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          return ListTile(
            title: Text(note['title']),
            subtitle: Text(note['content']),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteNote(note['id']);
              },
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => NoteEditDialog(
                  note: note,
                  onUpdate: (newTitle, newContent) {
                    updateNote(note['id'], newTitle, newContent);
                    Navigator.pop(context);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addNote();
        },
      ),
    );
  }
}

class NoteEditDialog extends StatefulWidget {
  final Map<String, dynamic> note;
  final Function(String, String) onUpdate;

  NoteEditDialog({required this.note, required this.onUpdate});

  @override
  _NoteEditDialogState createState() => _NoteEditDialogState();
}

class _NoteEditDialogState extends State<NoteEditDialog> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note['title']);
    _contentController = TextEditingController(text: widget.note['content']);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Note'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _contentController,
            decoration: InputDecoration(labelText: 'Content'),
            maxLines: null,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Save'),
          onPressed: () {
            final newTitle = _titleController.text;
            final newContent = _contentController.text;
            widget.onUpdate(newTitle, newContent);
          },
        ),
      ],
    );
  }
}
