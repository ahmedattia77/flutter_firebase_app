import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String id;
  final String title;
  final String subTitle;
  final String details;
  final int color;
  final DateTime? createdAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.details,
    required this.color,
    this.createdAt,
  });

  factory NoteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return NoteModel(
      id: doc.id,
      title: data['title'] ?? '',
      subTitle: data['subTitle'] ?? '',
      details: data['details'] ?? '',
      color: data['color'] ?? 0xFF2196F3,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'subTitle': subTitle,
      'details': details,
      'color': color,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
