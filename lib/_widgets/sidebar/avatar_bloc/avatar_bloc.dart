import 'dart:async';
import 'dart:io';

import 'package:app_qldt/_repositories/user_repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'avatar_event.dart';

part 'avatar_state.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  final BuildContext context;

  AvatarBloc(this.context, String avatarPath) : super(AvatarInitial(avatarPath));

  @override
  Stream<AvatarState> mapEventToState(
    AvatarEvent event,
  ) async* {
    if (event is PickAvatarEvent) {
      yield await _mapPickImageEventToState();
    }
  }

  Future<AvatarState> _mapPickImageEventToState() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null && pickedImage.path != '') {
      final croppedImage = await _cropImage(pickedImage.path);
      if (croppedImage != null) {
        final newAvatar = await _saveImage(croppedImage);
        return state.copyWith(file: newAvatar);
      }
    }

    return state;
  }

  Future<File?> _cropImage(String imagePath) async {
    File? croppedImage = await ImageCropper.cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Chỉnh sửa ảnh',
        hideBottomControls: true,
      ),
      compressQuality: 100,
      cropStyle: CropStyle.circle,
      iosUiSettings: IOSUiSettings(title: 'Chỉnh sửa ảnh'),
    );

    return croppedImage;
  }

  Future<File> _saveImage(File image) async {
    imageCache?.evict(FileImage(state.file));
    imageCache?.clear();

    final path = (await getApplicationDocumentsDirectory()).path;
    final fileExtension = extension(image.path);
    final newAvatar = await image.copy('$path/avatar$fileExtension');

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('avatar_path', newAvatar.path);
    context.read<UserRepository>().userDataModel.avatarPath = newAvatar.path;

    return newAvatar;
  }
}
