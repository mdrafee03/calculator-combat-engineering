import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

class Taskforce {
  String name;
  Color color;
  PdfColor pdfColor;
  Taskforce(this.name, this.color, this.pdfColor);
  static List<Taskforce> taskforces = [
    Taskforce("A", Color(0xffc0504d), PdfColor.fromInt(0xffc0504d)),
    Taskforce("B", Color(0xff0070c0), PdfColor.fromInt(0xff0070c0)),
    Taskforce("C", Color(0xff00b050), PdfColor.fromInt(0xff00b050)),
  ];
}
