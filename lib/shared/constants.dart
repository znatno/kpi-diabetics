import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFF5F5F5), width: 2)
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF2196F3), width: 2) // Color.pink[200]
  ),
);

const colorMainAccent = Color(0xFFFF8B2D);