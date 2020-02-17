import 'package:flutter/material.dart';

class Inspiration {
  final String inspirationID;
  final int id;
  final String title;
  final String file;
  final String file_content_type;
  final int likes;
  final String status;
  final bool isliked;
  final bool isdisliked;
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

