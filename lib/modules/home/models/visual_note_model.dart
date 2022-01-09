class VisualNoteModel {
  final String noteId;
  final int date;
  final String title;
  final String description;
  final String image;
  final String status;

  const VisualNoteModel({
    required this.noteId,
    required this.date,
    required this.title,
    required this.description,
    required this.image,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'date': date,
      'title': title,
      'description': description,
      'image': image,
      'status': status,
    };
  }

  factory VisualNoteModel.fromMap(Map<dynamic, dynamic> map) {
    return VisualNoteModel(
      noteId: map['noteId'] as String,
      date: map['date'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      status: map['status'] as String,
    );
  }
}
