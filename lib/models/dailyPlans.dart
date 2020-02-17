import "package:flutter/material.dart";

class DailyPlans{
  final String id;
  final String title;
  final String time;
  final String updated_at;
  final String status;

  DailyPlans({
    this.id,
    this.title,
    this.updated_at,
    this.time,
    this.status
  });
}