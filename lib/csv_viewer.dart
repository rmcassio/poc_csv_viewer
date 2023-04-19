import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Data {
  final String skuCode;
  final double baseValue;

  Data(this.skuCode, this.baseValue);
}

class CsvViewer extends StatefulWidget {
  const CsvViewer({super.key});

  @override
  CsvViewerState createState() => CsvViewerState();
}

class CsvViewerState extends State<CsvViewer> {
  final headers = ['CODIGO_SKU', 'VALOR_BASE'];
  final List<Data> _rows = [];

  Future<void> _openCsvFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (result != null) {
      if (_rows.isNotEmpty) {
        _rows.clear();
      }
      final csvString = String.fromCharCodes(result.files.single.bytes!);
      final csv = const CsvToListConverter(fieldDelimiter: ';', shouldParseNumbers: false).convert(csvString);
      for (var i = 0; i < csv.length; i++) {
        if (i == 0 && !(csv[i].every((element) => headers.any((e) => e == element.toString())))) {
          //erro
          return;
        } else if (i > 0) {
          String code;
          double? value;

          code = csv[i][0];
          value = double.tryParse(csv[i][1]);

          if (value == null) {
            //erro
            return;
          }

          _rows.add(Data(code, value));
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSV Viewer'),
      ),
      body: _rows.isNotEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 60,
                  child: Card(
                    margin: const EdgeInsets.all(3),
                    child: Row(
                      children: const [
                        SizedBox(width: 4),
                        Text('Código Sku', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        SizedBox(width: 8),
                        Text('Preço Base', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _rows.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 60,
                        child: Card(
                          margin: const EdgeInsets.all(3),
                          color: Colors.white,
                          child: Row(
                            children: [
                              const SizedBox(width: 25),
                              Text(_rows[index].skuCode.toString(), style: const TextStyle(fontSize: 16)),
                              const SizedBox(width: 60),
                              Text(_rows[index].baseValue.toString(), style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCsvFile,
        tooltip: 'Open CSV file',
        child: const Icon(Icons.folder_open),
      ),
    );
  }
}
