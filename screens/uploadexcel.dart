import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:justcall/modals/product.dart';
class UploadExcel extends StatefulWidget {

  const UploadExcel({super.key});

  @override
  State<UploadExcel> createState() => _UploadExcelState();
}

class _UploadExcelState extends State<UploadExcel> {

  PlatformFile? _selectedFile;
  late Future<List<Product>> _productsFuture;
  List<Product> productList = [];


  @override
  void initState() {
    super.initState();
    // _productsFuture = fetchProducts();
    print("object");
  }

  Future<void> refreshScreen() async {
    setState(() {
      // _productsFuture = fetchProducts();
    });
   print("fetch data ${_productsFuture}");
  }
  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['xlsx'], // Allow only Excel files
      type: FileType.custom,
    );

    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
        handleFileUpload(_selectedFile!.bytes!);
      });
    }
  }

  void handleFileUpload(List<int> bytes) async {
    try {
      List<Map<String, dynamic>> data = await parseExcel(Uint8List.fromList(bytes));
      await writeToFirestore(data);
    } catch (e) {
      print("Error uploading file: $e");
      // showErrorDialog("Error uploading file: $e");
    }
  }

  // Future<List<Map<String, dynamic>>> parseExcel(Uint8List bytes) async {
  //   var excel = Excel.decodeBytes(bytes);
  //
  //   var sheet = excel.tables.keys.first;
  //   var table = excel.tables[sheet];
  //
  //   List<Map<String, dynamic>> data = [];
  //   for (var row in table!.rows.skip(1)) { // Skip header row
  //     data.add({
  //       'BranchName': row[0]?.toString(),
  //       'ProductName': row[1]?.toString(),
  //       'Unit': row[2]?.toString(),
  //       'MainGroup': row[3]?.toString(),
  //       'SubGroup': row[4]?.toString(),
  //       'Barcode': row[5]?.toString(),
  //       'UnitCost': row[6]?.toString(),
  //       'ProfitMargin': row[7]?.toString(),
  //       'ProfitMarkup': row[8]?.toString(),
  //       'Price': row[9]?.toString(),
  //     });
  //   }
  //   print("parseExcel : ${data[0]}");
  //   return data;
  // }
  Future<List<Map<String, dynamic>>> parseExcel(Uint8List bytes) async {
    try {
      var excel = Excel.decodeBytes(bytes);
      var sheet = excel.tables.keys.first;
      var table = excel.tables[sheet]!;

      List<String> headers = [];
      List<Map<String, dynamic>> rows = [];

      for (int i = 0; i < table.rows.length; i++) {
        var row = table.rows[i];
        if (i == 0) {
          // Assuming the first row contains headers
          headers = row.map((cell) => cell?.value.toString() ?? '').toList();
        } else {
          Map<String, dynamic> rowData = {};
          for (int j = 0; j < headers.length; j++) {
            rowData[headers[j]] = convertToPrimitive(row[j]?.value);
          }
          rows.add(rowData);
        }
      }

      return rows;
    } catch (e) {
      print("Error parsing Excel: $e");
      // showErrorDialog("Error parsing Excel: $e");
      return [];
    }
  }

  dynamic convertToPrimitive(dynamic value) {
    if (value is String) {
      return value;
    } else if (value is num) {
      return value;
    } else if (value is bool) {
      return value;
    } else if (value is DateTime) {
      return value.toIso8601String(); // Convert DateTime to String
    } else {
      return value.toString(); // Convert any other type to String
    }
  }
  // Future<List<List<dynamic>>> parseExcel(Uint8List bytes) async {
  //   var excel = Excel.decodeBytes(bytes);
  //
  //   var sheet = excel.tables.keys.first;
  //   var table = excel.tables[sheet];
  //
  //   return table!.rows; // List<List<dynamic>>
  // }



  Map<String, dynamic> _postData = {};

  Future<void> fetchData(data) async {
    final String apiUrl = 'https://justcalltest.onrender.com/api/users/serpapi/${data}';
    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _postData = jsonDecode(response.body);
        });
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> sendJsonData(Map<String, dynamic> jsonData) async {
    try {
      final response = await http.post(
        Uri.parse("https://justcalltest.onrender.com/api/users/createProduct"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        // Successfully sent data
        // print('Data sent successfully');
      } else {
        // Error occurred while sending data
        print('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      print('Exception occurred: $e');
    }
  }


  Future<void> writeToFirestore(List<Map<String, dynamic>> data)  async {
    // print("writeToMysql : ${data[0]}");
    // await fetchData(data[0]["Product Name"]);
    // var imgUrlData = _postData["images"];
    // print("fetch data ${imgUrlData[1]["imageUrl"]}");
    print("upload start");
    for (var item in data) {

      // fetch image url
      // await fetchData(item["Product Name"]);
      // var imgUrlData = _postData["images"];

      //send data to product table
      final details = {
        'branchName': item["Branch Name"],
        'productName': item["Product Name"],
        'unit': item["Unit"],
        'mainGroup': item["Main Group"],
        'subGroup': item["Sub Group"],
        'barcode': item["Barcode"],
        'unitCost': item["Unit Cost"],
        'profitMargin': item["Profit Margin"],
        'profitMarkup': item["Profit Markup"],
        'price1': item["Price 1"],
        'imgUrl': "-",
      };
      await sendJsonData(details);
    };

    print("uploaded successfully");

    // var firestore = FirebaseFirestore.instance;
    // var batch = firestore.batch();
    // data.forEach((row) {
    //   if (row.isNotEmpty) {
    //     var docRef = firestore.collection('products').doc();
    //     batch.set(docRef, row);
    //   }
    // });
    // await batch.commit();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Upload Complete'),
          content: Text('Excel data uploaded to Firestore!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Future<List<Product>> fetchProducts() async {
  //   print("refresh");
  //   try {
  //     CollectionReference productsRef = FirebaseFirestore.instance
  //     // .collection('users')
  //     // .doc(uid)
  //         .collection('products');
  //
  //     QuerySnapshot querySnapshot = await productsRef.get();
  //     print('Error fetching products: $querySnapshot');
  //     return querySnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
  //   } catch (e) {
  //     print('Error fetching products: $e');
  //     throw Exception('Error fetching products: $e');
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _pickFile,
            child: Text('Pick Excel File'),
          ),
          SizedBox(height: 20),
          if (_selectedFile != null)
            Text('Selected File: ${_selectedFile!.name}'),
        ],
      ),
    );
  }
}
