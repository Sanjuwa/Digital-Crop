import 'dart:io';

import 'package:digitalcrop/constants.dart';
import 'package:digitalcrop/models/user_model.dart';
import 'package:digitalcrop/services/auth_service.dart';
import 'package:digitalcrop/services/database_service.dart';
import 'package:digitalcrop/services/storage_service.dart';
import 'package:digitalcrop/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latlong_to_osgrid/latlong_to_osgrid.dart';
import 'package:native_exif/native_exif.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ImageController extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  File? _pickedImage;
  String _language = instructions.keys.first;

  File? get image => _pickedImage;

  String get language => _language;

  set language(String lang) {
    _language = lang;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 300);
    if (photo != null) {
      _pickedImage = File(photo.path);
    }
    notifyListeners();
  }

  Future<void> uploadImage(BuildContext context) async {
    SimpleFontelicoProgressDialog pd =
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    pd.show(
      message: "Uploading image...",
      indicatorColor: kGreenColor,
      width: 0.6.sw,
      height: 150.h,
      textAlign: TextAlign.center,
      separation: 30.h,
    );

    User? user = await AuthService().currentUser;

    if (user != null) {
      try {
        Position position = await _determinePosition();

        final exif = await Exif.fromPath(_pickedImage!.path);
        final attributes = await exif.getAttributes();

        LatLongConverter converter = LatLongConverter();
        List convertedLatitude =
            converter.getDegreeFromDecimal(position.latitude);
        List convertedLongitude =
            converter.getDegreeFromDecimal(position.longitude);

        attributes!['GPSLatitude'] = _decimalToRational(convertedLatitude);
        attributes['GPSLongitude'] = _decimalToRational(convertedLongitude);
        attributes['GPSLatitudeRef'] = position.latitude > 0 ? "N" : "S";
        attributes['GPSLongitudeRef'] = position.longitude > 0 ? "E" : "W";

        await exif.writeAttributes(attributes);

        String imageName = await _generateImageName(user.uid);
        String? url =
            await _storageService.uploadImage(_pickedImage!, imageName);
        if (url != null) {
          _pickedImage = null;
          await DatabaseService().updateLastImageInfo(
              DateTime.now(), int.parse(imageName.split('_').last), user.uid);
          pd.hide();
          ToastBar(text: 'Image uploaded!', color: Colors.green).show();
          notifyListeners();
        } else {
          pd.hide();
          ToastBar(text: 'Upload failed!', color: Colors.red).show();
        }
      } catch (e) {
        pd.hide();
        print(e);
        ToastBar(text: e.toString(), color: Colors.red).show();
      }
    } else {
      pd.hide();
      ToastBar(text: 'Upload failed!', color: Colors.red).show();
    }
  }

  Future<String> _generateImageName(String uid) async {
    String date = DateFormat('yyyy_MM_dd').format(DateTime.now());

    Map lastImageData = await DatabaseService().getLastImageInfo(uid);
    DateTime lastDate = lastImageData['lastImageDate'] == null
        ? _simplifyDate(DateTime.now())
        : _simplifyDate(lastImageData['lastImageDate'].toDate());
    int lastCount = lastImageData['imageCountForLastDay'];

    int finalCount = 0;

    if (DateTime.now().difference(lastDate).inDays > 0) {
      finalCount = 1;
    } else {
      finalCount = lastCount + 1;
    }

    String imageName = "${uid}_${date}_$finalCount";
    return imageName;
  }

  DateTime _simplifyDate(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  String _decimalToRational(List dmsList) {
    return "${dmsList[0].abs()}/1,${dmsList[1]}/1,${(double.parse(dmsList[2].toStringAsFixed(3)) * 1000).toInt()}/1000";
  }
}
