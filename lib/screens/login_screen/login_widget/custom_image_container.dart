import 'package:dating_app/storage/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImageContainer extends StatelessWidget {
  const CustomImageContainer({Key? key})
      : super(key: key);
 // final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10,right: 10),
      child: Container(
        height: 120,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border(
              bottom: BorderSide(color: Theme.of(context).primaryColor, width: 1),
               top:   BorderSide(color: Theme.of(context).primaryColor, width: 1),
               left:   BorderSide(color: Theme.of(context).primaryColor, width: 1),
               right:   BorderSide(color: Theme.of(context).primaryColor, width: 1),
          ),
        ),
        child: Align(alignment: Alignment.bottomRight,
        child: IconButton(
            icon: Icon(Icons.add_a_photo, color: Theme.of(context).colorScheme.secondary,)
          , onPressed: () async {
              ImagePicker _imagePicker = ImagePicker();
              final XFile? _image = await _imagePicker.pickImage(source: ImageSource.gallery );
              if(_image == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No image selected'),));
              }
              if(_image != null) {
                print('load pict');
                StorageRepo().uploadImage(_image);
              }
              },),)
      ),
    );
  }
}
