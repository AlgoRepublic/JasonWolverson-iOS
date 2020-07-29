import 'package:flutter/material.dart';

class Inspiration {
  String inspirationID;
  int id;
  String title;
  String file;
  String file_content_type;
  int likes;
  String status;
  bool isliked;
  bool isdisliked;
//  final String

  Inspiration({
    this.inspirationID,
    this.id,
    this.title,
    this.file,
    this.likes,
    this.status,
    this.file_content_type,
    this.isliked,
    this.isdisliked
  });
}

