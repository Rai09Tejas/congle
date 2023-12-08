import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<XFile> assetToXFile(Asset asset) async {
  final ByteData byteData = await asset.getByteData();
  final List<int> imageData = byteData.buffer.asUint8List();
  
  final String tempFileName = DateTime.now().millisecondsSinceEpoch.toString();
  
  // Get the temporary directory using the path_provider plugin
  final String tempPath = (await getTemporaryDirectory()).path;
  
  final File tempFile = File('$tempPath/$tempFileName.jpg');
  
  // Write the file
  await tempFile.writeAsBytes(imageData);
  
  // Return the XFile
  return XFile(tempFile.path);
}