import 'package:flutter/material.dart';

class Topic {
  const Topic({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });

  final int id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
}
