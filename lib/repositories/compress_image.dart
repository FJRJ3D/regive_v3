import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

Future<File> compressImage(File file) async {
  final dir = await getTemporaryDirectory();

  final tempPath = path.join(
    dir.path,
    'temp_${path.basename(file.path)}',
  );

  final compressedXFile = await FlutterImageCompress.compressAndGetFile(
    file.path,
    tempPath,
    quality: 60,
    minWidth: 800,
  );

  if (compressedXFile != null) {
    final original = File(file.path);
    await original.delete();
    return File(compressedXFile.path).rename(file.path);
  } else {
    throw Exception('Image compression failed');
  }
}
