import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:visual_notes/modules/home/models/visual_note_model.dart';

class NotesRepo {
  NotesRepo._();

  static final instance = NotesRepo._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String _path = join(await getDatabasesPath(), 'Notes.db');
    Database _database = await openDatabase(
      _path,
      version: 1,
      onCreate: _onCreate,
    );
    return _database;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE Notes (
        noteId TEXT PRIMARY KEY,
        date INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        image TEXT NOT NULL,
        status TEXT NOT NULL)
      ''');
  }

  Future<List<VisualNoteModel>> getAllNotes() async {
    Database _db = await database;
    List<Map> _notesMaps = await _db.rawQuery('SELECT * FROM Notes');
    List<VisualNoteModel> _notesList = _notesMaps.isNotEmpty
        ? _notesMaps.map((note) => VisualNoteModel.fromMap(note)).toList()
        : [];
    return _notesList;
  }

  Future addNote({
    required VisualNoteModel visualNoteModel,
  }) async {
    Database _db = await database;
    await _db.insert('Notes', {
      'noteId': visualNoteModel.noteId,
      'date': visualNoteModel.date,
      'title': visualNoteModel.title,
      'description': visualNoteModel.description,
      'image': visualNoteModel.image,
      'status': visualNoteModel.status,
    });
  }

  Future deleteNote({
    required String noteId,
  }) async {
    Database _db = await database;
    await _db.delete(
      'Notes',
      where: 'noteId = ?',
      whereArgs: [noteId],
    );
  }

  Future updateNote({
    required VisualNoteModel visualNoteModel,
    required String oldNoteId,
  }) async {
    Database _db = await database;
    await _db.update(
      'Notes',
      {
        'noteId': visualNoteModel.noteId,
        'date': visualNoteModel.date,
        'title': visualNoteModel.title,
        'description': visualNoteModel.description,
        'image': visualNoteModel.image,
        'status': visualNoteModel.status,
      },
      where: 'noteId = ?',
      whereArgs: [oldNoteId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future deleteMultipleNotes({required List<String> notesIds}) async {
    Database _db = await database;
    await _db.delete(
      'Notes',
      where: 'noteId IN (${List.filled(notesIds.length, '?').join(',')})',
      whereArgs: notesIds,
    );
  }

  Future deleteAllNotes() async {
    Database _db = await database;
    await _db.rawDelete('DELETE * FROM Notes');
  }
}
