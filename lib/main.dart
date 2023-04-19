import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poc_csv_viewer/csv_viewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: "CSV VIEWER"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CsvViewer(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final result = await FilePicker.platform.pickFiles(
      //       type: FileType.custom,
      //       allowedExtensions: ['csv'],
      //     );
      //
      //     if (result != null) {
      //       final fileBytes = result.files.single.bytes!;
      //       final tempDirectory = await Directory.systemTemp.createTemp();
      //       final tempFile = File('${tempDirectory.path}/temp_file');
      //       await tempFile.writeAsBytes(fileBytes);
      //     }
      //   },
      //   tooltip: 'Adicionar csv file',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
