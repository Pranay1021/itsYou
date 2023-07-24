

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crew/servies/database.dart';

class ProfileController with ChangeNotifier {

  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;
  Uint8List? imageBytes; 

//image picker from gallery
  Future pickGalleryImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 100);
    
    if(pickedFile != null){ 
    _image = XFile(pickedFile.path);
    imageBytes = await _image!.readAsBytes();
    String resp = await StoreData().saveData(file: imageBytes!);
      notifyListeners();
    }
    }
  
  //image picekr from camera
  Future pickCameraImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera,imageQuality: 100);
    
    if(pickedFile != null){ 
    _image = XFile(pickedFile.path);
    imageBytes = await _image!.readAsBytes();
    String resp = await StoreData().saveData(file: imageBytes!);
    notifyListeners();
    }
    }
  
  void saveProfile() async{
      
  }

  //to pick image i.e dialog box
  void pickImage(context){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Choose Image Source'),
        content: 
        SingleChildScrollView(
          child: ListBody(
            children: [
              ListTile(
                onTap: (){
                  pickGalleryImage(context);
                  
                  Navigator.pop(context);
                },
                title: Text('Gallery'),
                leading: Icon(Icons.image),
              ),
              ListTile(
                onTap: (){ 
                  pickCameraImage(context);
            
                  Navigator.pop(context);
                },
                title: Text('Camera'),
                leading: Icon(Icons.camera),
              ),
            ],
          ),
        ),
      );
    }
    );
  }
}