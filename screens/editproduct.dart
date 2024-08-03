// import 'dart:convert';
// import 'dart:html' as html;
// import 'dart:io';
// import 'dart:math';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:photo_view/photo_view.dart';
//
// class EditProduct extends StatefulWidget {
//   final String productId;
//   final Map<String, dynamic> currentProductData;
//   EditProduct({required this.productId, required this.currentProductData});
//
//   @override
//   _EditProductPageState createState() => _EditProductPageState();
// }
//
// class _EditProductPageState extends State<EditProduct> {
//   late String _productName;
//   late String _productDescription;
//   late String _productPrice;
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController productName;
//   late TextEditingController productPrice;
//
//   String price = '';
//   String name = '';
//   late String _productCategory;
//   late String _productType;
//   // XFile? _productImage;
//   Random random = Random();
//   List<Uint8List> _productImages = [];
//   Uint8List? _selectedFile;
//   Uint8List? _imageData;
//   bool? indicator = false;
//   bool? indicatorDelete = false;
//   String? base64Image;
//
//   @override
//   void initState() {
//     super.initState();
//     _productName = widget.currentProductData['name'];
//     _productDescription = widget.currentProductData['description'];
//     _productType = widget.currentProductData['productType'];
//
//     productName = TextEditingController(text: widget.currentProductData['name']);
//     productPrice = TextEditingController(text: widget.currentProductData['description']);
//     setState(() {
//       base64Image = widget.currentProductData['img'];
//     });
//     // productName = widget.currentProductData['name'];
//   }
//
//   Future<void> _pickImages() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowMultiple: true,
//     );
//
//     if (result != null) {
//       setState(() {
//         _selectedFile =  result.files.first.bytes;
//         _productImages = result.files.map((file) => file.bytes!).toList();
//       });
//     }
//   }
//
//   html.File? _selectedFiles;
//
//   void _pickFile() {
//     html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
//     uploadInput.accept = 'image/*';
//     uploadInput.click();
//     uploadInput.onChange.listen((e) {
//       final files = uploadInput.files;
//       if (files!.isNotEmpty) {
//         setState(() {
//           _selectedFiles = files.first;
//           _readFile(_selectedFiles!);
//         });
//       }
//     });
//
//     uploadInput.onChange.listen((event) {
//       final file = uploadInput.files?.first;
//       if (file != null) {
//         final reader = html.FileReader();
//         reader.readAsDataUrl(file);
//
//         reader.onLoadEnd.listen((event) {
//           setState(() {
//             base64Image = reader.result as String?;
//           });
//         });
//       }
//     });
//   }
//
//   void _readFile(html.File file) {
//     final reader = html.FileReader();
//     reader.readAsArrayBuffer(file);
//     reader.onLoadEnd.listen((e) {
//       setState(() {
//         _imageData = reader.result as Uint8List?;
//       });
//     });
//   }
//
//
//
//   Future<void> _pickFileuploadFile() async {
//     if (_selectedFile == null) {
//       print('No file selected');
//       return;
//     }
//
//     try {
//       final reader = html.FileReader();
//       reader.readAsArrayBuffer(_selectedFiles!);
//       reader.onLoadEnd.listen((e) async {
//         final fileBytes = reader.result as List<int>;
//         final uri = Uri.parse('https://justcalltest.onrender.com/api/users/updateProduct');
//         final uriOffer = Uri.parse('https://justcalltest.onrender.com/api/users/offers');
//         final request = http.MultipartRequest('POST', widget.productId == "0" ? uriOffer : uri);
//         request.files.add(http.MultipartFile.fromBytes(
//           'image',
//           fileBytes,
//           filename: widget.currentProductData['productType'],
//         ));
//         request.fields['barcode'] = widget.currentProductData['productType'];
//         print('Sending request to $uri');
//         final response = await request.send();
//         print('Response status: ${response.statusCode}');
//
//         if (response.statusCode == 200) {
//           print('Uploaded successfully');
//         } else {
//           print('Upload failed with status: ${response.statusCode}');
//         }
//       });
//     } catch (e) {
//       print('Error during file upload: $e');
//     }
//   }
//
//   Future<void> _uploadFile() async {
//
//
//     var uri = Uri.parse('https://justcalltest.onrender.com/api/users/updateProduct');
//     var request = http.MultipartRequest('PUT', uri);
//     // final fileBytes = await _selectedFiles!.arrayBuffer().then((value) => value.asUint8List());
//     request.files.add(http.MultipartFile.fromBytes(
//       'image',
//       // _selectedFile!,
//       _imageData!,
//       // fileBytes,
//       // await _selectedFile!.arrayBuffer().then((value) => value.asUint8List()),
//       filename : widget.currentProductData['productType'],
//     ));
//
//     // Add any additional fields if needed
//     request.fields['barcode'] = widget.currentProductData['productType'];
//
//
//     try {
//       var response = await request.send();
//       if (response.statusCode == 200) {
//         print('File uploaded successfully.');
//         setState(() {
//           indicator = false;
//         });
//       } else {
//         print('Failed to upload file. Status code: ${response.statusCode}');
//         setState(() {
//           indicator = false;
//         });
//       }
//     } catch (e) {
//       print('Error uploading file: $e');
//       setState(() {
//         indicator = false;
//       });
//     }
//   }
//
//
//   //
//   //
//
//   Future<void> updateProduct() async {
//       final data = {
//         // "img" : _selectedFile,
//         "img" : base64Image,
//         "barcode" :  widget.currentProductData['productType']
//       };
//
//       final updateOfferData = {
//         "id" : widget.currentProductData['id'],
//         "Name" : productName.text.trim(),
//         "Price" : productPrice.text.trim(),
//         'Image' : base64Image,
//       };
//
//     try {
//       final uri = 'https://justcalltest.onrender.com/api/users/updateProductImage';
//       final uriUpdateOffer = 'https://justcalltest.onrender.com/api/users/updateOffersProduct';
//     final response = await  http.put(
//       Uri.parse(widget.productId == "editOffer" ? uriUpdateOffer : uri),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(widget.productId == "editOffer" ? updateOfferData : data),
//       );
//       print(response);
//       if (response.statusCode == 200) {
//         // Successfully sent data
//         print('Data sent successfully');
//         setState(() {
//           indicator = false;
//         });
//       } else {
//         // Error occurred while sending data
//         print('Failed to send data: ${response.statusCode}');
//         setState(() {
//           indicator = false;
//         });
//       }
//     } catch (e) {
//       // Exception occurred
//       setState(() {
//         indicator = false;
//       });
//       print('Exception occurred: $e');
//     }
//   }
//
//   Future<void> addOfferProduct() async {
//
//     final offerData = {
//       "Name" : productName.text.trim(),
//       "Price" : productPrice.text.trim(),
//       "Image" : base64Image,
//     };
//     // print('Data sent successfully');
//     try {
//       final uriOffer = 'https://justcalltest.onrender.com/api/users/offers';
//
//       final response = await  http.post(
//         Uri.parse( uriOffer),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(offerData),
//       );
//       print(response);
//       if (response.statusCode == 200) {
//         // Successfully sent data
//         print('Offer data sent successfully ');
//         setState(() {
//           indicator = false;
//         });
//       } else {
//         // Error occurred while sending data
//         print('Failed to send offer data: ${response.statusCode}');
//         setState(() {
//           indicator = false;
//         });
//       }
//     } catch (e) {
//       // Exception occurred
//       setState(() {
//         indicator = false;
//       });
//       print('Exception occurred: $e');
//     }
//   }
//
//   Future<void> deleteOfferProduct() async {
//
//
//     try {
//       print(": ${widget.currentProductData['id']}");
//       final uri = 'https://justcalltest.onrender.com/api/users/deleteOfferById/${widget.currentProductData['id']}';
//       final uriUpdateOffer = 'https://justcalltest.onrender.com/api/users/updateOffersProduct';
//       final response = await  http.delete(
//         Uri.parse(uri),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         // body: jsonEncode(widget.productId == "editOffer" ? updateOfferData : data),
//       );
//       print(response);
//       if (response.statusCode == 200) {
//         // Successfully sent data
//         print('Data sent successfully');
//         setState(() {
//           indicatorDelete = false;
//         });
//         Navigator.of(context).pop();
//       } else {
//         // Error occurred while sending data
//         print('Failed to send data: ${response.statusCode}');
//         setState(() {
//           indicatorDelete = false;
//         });
//       }
//     } catch (e) {
//       // Exception occurred
//       setState(() {
//         indicatorDelete = false;
//       });
//       print('Exception occurred: $e');
//     }
//   }
//
//
//   // Future<String> uploadImage(Uint8List imageData, String fileName) async {
//   //   try {
//   //     print("upload Images step 1");
//   //     String uid = FirebaseAuth.instance.currentUser!.uid;
//   //     print("upload Images step 2 ${uid}");
//   //     Reference storageRef = FirebaseStorage.instance
//   //         .ref()
//   //         .child('products')
//   //         .child(uid)
//   //         .child(fileName);
//   //     // Reference storageRef = FirebaseStorage.instance.ref("products/${fileName}.jpg");
//   //     print("upload Images step  ${storageRef}");
//   //     UploadTask uploadTask = storageRef.putData(imageData);
//   //     print("uploadTask  ${uploadTask}");
//   //     uploadTask.whenComplete(() async {
//   //       print("uploadTask  ${uploadTask.snapshot.ref.getDownloadURL()}");
//   //     });
//   //     TaskSnapshot snapshot = await uploadTask;
//   //     print("uploadTask  ${snapshot.ref.getDownloadURL()}");
//   //     String downloadUrl = await snapshot.ref.getDownloadURL();
//   //     print("upload Images step 3 ${downloadUrl}");
//   //     return downloadUrl;
//   //   } catch (e) {
//   //     print('Error uploading image: $e');
//   //     throw Exception('Error uploading image: $e');
//   //   }
//   // }
//
//
//
//   // Future<void> updateProduct() async {
//   //   try {
//   //     Map<String, dynamic> updatedData = {
//   //       'name': _productName,
//   //       'description': _productDescription,
//   //       'productType': _productType,
//   //       'gender': _selectedGender,
//   //       'category': _selectedCategory,
//   //       'color': _selectedColor,
//   //       'role': _selectedPromotion,
//   //       'createdAt': Timestamp.now(),
//   //     };
//   //     await FirebaseFirestore.instance
//   //         .collection('products') // Replace with your collection name
//   //         .doc(widget.productId)
//   //         .update(updatedData);
//   //     print('Product updated successfully');
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Product updated successfully!')),
//   //     );
//   //     setState(() {
//   //       indicator = false;
//   //     });
//   //   } catch (e) {
//   //     print('Error updating product: $e');
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Failed to add product: $e')),
//   //     );
//   //     setState(() {
//   //       indicator = false;
//   //     });
//   //   }
//   // }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFEEEEEE),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: <Widget>[
//               Text(
//                 "Edit Product",
//                 style: GoogleFonts.teko(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black,
//                   decoration: TextDecoration.none,
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               TextFormField(
//                 controller: productName,
//                 // initialValue: _productName,
//                 decoration: InputDecoration(
//                   labelText: 'Product Name',
//                   labelStyle: GoogleFonts.poppins(
//                     fontSize: 16,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.black,
//                     decoration: TextDecoration.none,
//                   ),
//                 ),
//                 onSaved: (value) {
//                   setState(() {
//                     name = value!;
//                   });
//
//                   _productName = value!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter product name';
//                   }
//                   return null;
//                 },
//               ),
//               // SizedBox(
//               //   height: 10,
//               // ),
//               // TextFormField(
//               //   initialValue: _productDescription,
//               //   decoration: InputDecoration(
//               //     labelText: 'Product Price',
//               //     labelStyle: GoogleFonts.poppins(
//               //       fontSize: 16.sp,
//               //       fontWeight: FontWeight.normal,
//               //       color: Colors.black,
//               //       decoration: TextDecoration.none,
//               //     ),
//               //   ),
//               //   onSaved: (value) {
//               //     _productDescription = value!;
//               //   },
//               //   validator: (value) {
//               //     if (value == null || value.isEmpty) {
//               //       return 'Please enter product description';
//               //     }
//               //     return null;
//               //   },
//               // ),
//               SizedBox(height: 10,),
//               TextFormField(
//                 controller: productPrice,
//                 decoration: InputDecoration(labelText: 'Product Price',
//                   labelStyle:GoogleFonts.poppins(
//                     fontSize : 16 ,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.black,
//                     decoration: TextDecoration.none,
//                   ),),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) {
//                   // _productPrice = double.parse(value!);
//                   setState(() {
//                     price = value!;
//                   });
//                   _productPrice = value!;
//                   // price = value!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter product price';
//                   }
//                   return null;
//                 },
//               ),
//               // SizedBox(
//               //   height: 10,
//               // ),
//               // TextFormField(
//               //   initialValue: _productType,
//               //   decoration: InputDecoration(
//               //     labelText: 'Product Type',
//               //     labelStyle: GoogleFonts.poppins(
//               //       fontSize: 16,
//               //       fontWeight: FontWeight.normal,
//               //       color: Colors.black,
//               //       decoration: TextDecoration.none,
//               //     ),
//               //   ),
//               //   onSaved: (value) {
//               //     _productType = value! + '${random.nextInt(10000)}';
//               //   },
//               //   validator: (value) {
//               //     if (value == null || value.isEmpty) {
//               //       return 'Please enter product category';
//               //     }
//               //     return null;
//               //   },
//               // ),
//               SizedBox(height: 20),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//               //   children: [
//               //     DropdownButton<String>(
//               //       hint: Text(
//               //         'Gender',
//               //         style: TextStyle(
//               //             color: _selectedGenderCheck == false
//               //                 ? Colors.black
//               //                 : Colors.red),
//               //       ),
//               //       value: _selectedGender,
//               //       items: _dropdownGender.map((String item) {
//               //         return DropdownMenuItem<String>(
//               //           value: item,
//               //           child: Text(item),
//               //         );
//               //       }).toList(),
//               //       onChanged: (String? newValue) {
//               //         setState(() {
//               //           _selectedGender = newValue!;
//               //         });
//               //       },
//               //     ),
//               //     DropdownButton<String>(
//               //       hint: Text(
//               //         'Category',
//               //         style: TextStyle(
//               //             color: _selectedCategoryCheck == false
//               //                 ? Colors.black
//               //                 : Colors.red),
//               //       ),
//               //       value: _selectedCategory,
//               //       items: _dropdownCategory.map((String item) {
//               //         return DropdownMenuItem<String>(
//               //           value: item,
//               //           child: Text(item),
//               //         );
//               //       }).toList(),
//               //       onChanged: (String? newValue) {
//               //         setState(() {
//               //           _selectedCategory = newValue!;
//               //         });
//               //       },
//               //     ),
//               //     DropdownButton<String>(
//               //       hint: Text(
//               //         'Color',
//               //         style: TextStyle(
//               //             color: _selectedColorCheck == false
//               //                 ? Colors.black
//               //                 : Colors.red),
//               //       ),
//               //       value: _selectedColor,
//               //       items: _dropdownColor.map((String item) {
//               //         return DropdownMenuItem<String>(
//               //           value: item,
//               //           child: Text(item),
//               //         );
//               //       }).toList(),
//               //       onChanged: (String? newValue) {
//               //         setState(() {
//               //           _selectedColor = newValue!;
//               //         });
//               //       },
//               //     ),
//               //     DropdownButton<String>(
//               //       hint: Text(
//               //         'Role',
//               //         style: TextStyle(
//               //             color: _selectedPromotionCheck == false
//               //                 ? Colors.black
//               //                 : Colors.red),
//               //       ),
//               //       value: _selectedPromotion,
//               //       items: _dropdownPromotion.map((String item) {
//               //         return DropdownMenuItem<String>(
//               //           value: item,
//               //           child: Text(item),
//               //         );
//               //       }).toList(),
//               //       onChanged: (String? newValue) {
//               //         setState(() {
//               //           _selectedPromotion = newValue!;
//               //         });
//               //       },
//               //     ),  ],
//               // ),
//               widget.currentProductData['img'] != "" ?
//               _imageData == null ?
//               Image.memory(base64Decode(base64Image!.split(',')[1]),width: 100,height: 100,) : SizedBox() : SizedBox(),
//
//                   if (_imageData != null) ...[
//                 SizedBox(height: 20),
//                 Image.memory(_imageData!, height: 100, width: 100),
//               ],
//               SizedBox(height: 20),
//               SizedBox(height: 20),
//               // _productImage == null
//               _productImages.isEmpty
//                   ? Text(
//                       'No image selected.',
//                       style: GoogleFonts.teko(
//                         fontSize: 20,
//                         fontWeight: FontWeight.normal,
//                         color: Colors.black,
//                         decoration: TextDecoration.none,
//                       ),
//                     )
//                   : Wrap(
//                       spacing: 8.0,
//                       runSpacing: 8.0,
//                       children: _productImages.map((imageData) {
//                         return GestureDetector(
//                           // onTap: () => _showImage(context, imageData),
//                           child: Image.memory(
//                             imageData,
//                             width: 100,
//                             height: 100,
//                             fit: BoxFit.cover,
//                           ),
//                         );
//                       }).toList(),
//                     ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 // onPressed: _pickImages,
//                 onPressed: _pickFile,
//                 child: Text(
//                   "Upload Image",
//                   style: GoogleFonts.teko(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white,
//                     decoration: TextDecoration.none,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                         0), // Set the border radius to 0 for a rectangular shape
//                   ),
//                   backgroundColor: Colors.grey,
//                 ),
//               ),
//
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     indicator = true;
//                   });
//                   // _uploadFile();
//                   // _pickFileuploadFile();
//                   widget.productId == "0" ?
//                       addOfferProduct() :
//                       updateProduct();
//                 },
//                 child: indicator == true ?
//                 Center(child:
//                 SizedBox(
//                   height: 10,
//                   width: 10,
//                   child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     strokeWidth: 2.0,
//                   ),
//                 )) : Text(
//                   'Submit',
//                   style: GoogleFonts.teko(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white,
//                     decoration: TextDecoration.none,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                         0), // Set the border radius to 0 for a rectangular shape
//                   ),
//                   backgroundColor: Colors.green,
//                 ),
//               ),
//               SizedBox(height: 20),
//               // widget.productId == "0" ?
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     indicatorDelete = true;
//                   });
//                   deleteOfferProduct();
//                 },
//                 child: indicatorDelete == true ?
//                 Center(child:
//                 SizedBox(
//                   height: 10,
//                   width: 10,
//                   child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     strokeWidth: 2.0,
//                   ),
//                 )) :
//                 Text(
//                   'Delete',
//                   style: GoogleFonts.teko(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white,
//                     decoration: TextDecoration.none,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                         0), // Set the border radius to 0 for a rectangular shape
//                   ),
//                   backgroundColor: Colors.redAccent,
//                 ),
//               )
//                   // : SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // class ImageZoomView extends StatelessWidget {
// //   final Uint8List imageData;
// //
// //   ImageZoomView({required this.imageData});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Image Zoom'),
// //       ),
// //       body: Center(
// //         child: PhotoView(
// //           imageProvider: MemoryImage(imageData),
// //         ),
// //       ),
// //     );
// //   }
// // }
