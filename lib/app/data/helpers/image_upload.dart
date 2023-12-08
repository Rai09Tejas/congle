import 'package:get/get.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

upload(File imageFile) async {
  // open a bytestream
  var stream = http.ByteStream(imageFile.openRead());
  // get file length
  var length = await imageFile.length();

  // string to uri
  var uri = Uri.parse("http://ip:8082/composer/predict");

  // create multipart request
  var request = http.MultipartRequest("POST", uri);

  // multipart that takes file
  var multipartFile = http.MultipartFile('file', stream, length,
      filename: basename(imageFile.path));

  // add file to multipart
  request.files.add(multipartFile);

  // send
  var response = await request.send();
  Get.log("${response.statusCode}");

  // listen for response
  response.stream.transform(utf8.decoder).listen((value) {
    Get.log(value);
  });
}

// upload(File(filePath));


// void onTakePictureButtonPressed() {
//   takePicture().then((String filePath) {
//     if (mounted) {
//       setState(() {
//         imagePath = filePath;
//         videoController?.dispose();
//         videoController = null;
//       });

//       // initiate file upload
//       Upload(File(filePath));

//       if (filePath != null) showInSnackBar('Picture saved to $filePath');
//     }
//   });
// }
