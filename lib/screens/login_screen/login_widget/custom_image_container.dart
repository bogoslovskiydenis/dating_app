import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../bloc/blocks.dart';

class CustomImageContainer extends StatelessWidget {
  const CustomImageContainer({Key? key, this.imageUrls})
      : super(key: key);

  final String? imageUrls;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 10),
      child: Container(
          height: 150,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border(
              bottom: BorderSide(color: Theme
                  .of(context)
                  .primaryColor, width: 1),
              top: BorderSide(color: Theme
                  .of(context)
                  .primaryColor, width: 1),
              left: BorderSide(color: Theme
                  .of(context)
                  .primaryColor, width: 1),
              right: BorderSide(color: Theme
                  .of(context)
                  .primaryColor, width: 1),
            ),
          ),
          child:

          (imageUrls == null) ?
          Align(alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(Icons.add_a_photo, color: Theme
                  .of(context)
                  .colorScheme
                  .secondary,)
              , onPressed: () async {
              ImagePicker _picker = ImagePicker();
              final XFile? _image = await _picker.pickImage(
                  source: ImageSource.gallery);
              if (_image == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No image selected'),));
              }
              if (_image != null) {
                log('load pict');
                context.read<LoginBloc>().add(UpdateUserImages(image: _image));
              }
            },
            ),
          ) : Image.network(imageUrls! , fit: BoxFit.cover,),
    ),
    );
  }
}
