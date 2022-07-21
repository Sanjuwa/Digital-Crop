import 'dart:io';

import 'package:digitalcrop/constants.dart';
import 'package:digitalcrop/services/storage_service.dart';
import 'package:digitalcrop/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ImageController extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  File? _pickedImage;

  File? get image => _pickedImage;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      _pickedImage = File(photo.path);
    }
    notifyListeners();
  }

  Future<void> uploadImage(BuildContext context) async {
    SimpleFontelicoProgressDialog pd =
    SimpleFontelicoProgressDialog(context: context, barrierDimisable: false);
    pd.show(
      message: "Uploading image...",
      indicatorColor: kGreenColor,
      width: 0.6.sw,
      height: 150.h,
      textAlign: TextAlign.center,
      separation: 30.h,
    );

    String? url = await _storageService.uploadImage(_pickedImage!, 'image');
    if (url != null) {
      _pickedImage = null;
      pd.hide();
      ToastBar(text: 'Image uploaded!', color: Colors.green).show();
      notifyListeners();
    } else {
      pd.hide();
      ToastBar(text: 'Upload failed!', color: Colors.red).show();
    }
  }
}
