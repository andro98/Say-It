
import 'dart:io';

import 'package:sayit/providers/BaseProviders.dart';
import 'package:sayit/providers/StorageProvider.dart';

class StorageRepository{
  BaseStorageProvider storageProvider = StorageProvider();
  Future<String> uploadImage(File file, String path) => storageProvider.uploadImage(file, path);
}