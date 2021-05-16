import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2)
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorMainAccent, width: 2) // Color.pink[200]
  ),
);

const colorMainAccent = Color(0xFFFF8B2D);