import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String> getFilePath(String filename) async {
  Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
  String appDocumentsPath = appDocumentsDirectory.path; // 2
  String filePath = '$appDocumentsPath/$filename'; // 3

  return filePath;
}

Future<File> saveImageToFile(Image image) async {
  File file = File(await getFilePath('upload.webp')); // 1
  file.writeAsString(image.toStringDeep()); // 2
  return file;
}