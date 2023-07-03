import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:runner_plan_app/core/exception/custom_firebase_exception.dart';
import 'package:runner_plan_app/core/interface/user/user_interface.dart';

class UserImage extends StatefulWidget {
  UserImage({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.canChange = false,
  }) : super(key: key);

  String imageUrl;
  final double height;
  final double width;
  final bool canChange;

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File? _image;
  bool _isLoading = false;

  void _showError(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ops...'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 500,
    );

    if (pickedImage != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        setState(() {
          _image = File(pickedImage.path);
        });

        String? responseUrl = await UserInterface().uploadUserImage(_image!);

        setState(() {
          widget.imageUrl = responseUrl!;
        });
      } on CustomFirebaseException catch (error) {
        _showError(error.toString());
      } catch (error) {
        _showError('Ocorreu um erro inesperado!');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  renderImage() {
    return widget.imageUrl.contains('assets/')
        ? AssetImage(widget.imageUrl)
        : NetworkImage(widget.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CircleAvatar(backgroundImage: renderImage()),
          if (_isLoading)
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (widget.canChange)
            Positioned(
                bottom: 0,
                right: -25,
                child: RawMaterialButton(
                  onPressed: _pickImage,
                  elevation: 2.0,
                  fillColor: Theme.of(context).colorScheme.background,
                  padding: const EdgeInsets.all(15.0),
                  shape: const CircleBorder(),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )),
        ],
      ),
    );
  }
}
