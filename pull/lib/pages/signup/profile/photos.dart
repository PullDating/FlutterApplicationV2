import 'dart:io';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull/providers/account_setup/photos.dart';
import 'package:pull/providers/max_profile_image_count.dart';
import 'package:pull/providers/min_profile_image_count.dart';
import 'package:reorderables/reorderables.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PhotoPage extends ConsumerStatefulWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  ConsumerState<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends ConsumerState<PhotoPage> {

  @override
  initState() {
    print("running init state for photos page");
    super.initState();
  }

  void deleteImageCallback(int index){ //for when a thumbnail deletes an image.
    ref.read(accountCreationPhotosProvider).removeAt(index);
  }

  Future pickImage(int index) async {
    try {
      print("trying to pick image.");
      final XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageFile == null){
        print("image was null, didn't pick image.");
        return;
      }
      ref.read(accountCreationPhotosProvider).insert(index, Image.file(File(imageFile.path)));
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      //check to make sure they aren't arranging the empty ones
      ref.read(accountCreationPhotosProvider).insert(newIndex, ref.read(accountCreationPhotosProvider).elementAt(oldIndex));
      ref.read(accountCreationPhotosProvider).removeAt(oldIndex + 1);
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Image> imageList = ref.watch(accountCreationPhotosProvider)!;
    int maxProfilePhotos = ref.watch(maxProfileImageCountProvider);
    int minProfilePhotos = ref.watch(minProfileImageCountProvider);
    bool mandatoryFilled = imageList.length > minProfilePhotos;
    int totalFilled = imageList.length;

    var tiles = <ImageThumbnail>[];

    //these are the mandatory photos that need to be filled in.
    for(int i = 0; i < minProfilePhotos; i++){
      tiles.add(ImageThumbnail(
        image: (totalFilled > i+1)? imageList[i]: null,
        pickImage: pickImage,
        deleteImageCallback: deleteImageCallback,
        index: i,
        required: true,
        mandatoryFilled: mandatoryFilled,
      ));
    }

    //these are the ones that are optional, but only show the number they have plus one to ensure they add the correct order.
    for(int i = minProfilePhotos; i < min(max(minProfilePhotos+1, totalFilled+1),maxProfilePhotos); i++){
      tiles.add(ImageThumbnail(
        image: (totalFilled > i+1)? imageList[i] : null,
        pickImage: pickImage,
        deleteImageCallback: deleteImageCallback,
        index: i,
        required: false,
        mandatoryFilled: mandatoryFilled,
      ));
    }

    return Material(
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: WrapList(
                  onReorder: _onReorder,
                  tiles: tiles,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class WrapList extends StatelessWidget {
  List<Widget> tiles;
  Function(int,int) onReorder;
  WrapList(
      {
        Key? key,
        required List<Widget> this.tiles,
        required Function(int,int) this.onReorder,
      }) : super(key: key);

  final double _iconSize = 90;

  @override
  Widget build(BuildContext context) {
    return ReorderableWrap(
      spacing: 8.0,
      runSpacing: 4.0,
      //padding: const EdgeInsets.all(8),
      onReorder: onReorder,
      onNoReorder: (int index) {
        debugPrint(
            '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
      },
      onReorderStarted: (int index) {
        debugPrint(
            '${DateTime.now().toString().substring(5, 22)} reorder started. index:$index');
      },
      children: tiles,
    );
  }
}

class ImageThumbnail extends StatelessWidget {
  ImageThumbnail({
    Key? key,
    required this.pickImage,
    required this.deleteImageCallback,
    this.image,
    required this.index,
    required this.required,
    required this.mandatoryFilled,
  }) : super(key: key);

  //functions in the parent to call
  Function pickImage;
  Function deleteImageCallback;

  //payload
  Image? image;

  //relevant state variables
  int index;
  bool required;
  bool mandatoryFilled;

  @override
  Widget build(BuildContext context) {
    final size = 40.0; //just a variable to determine size of the tiles.

    if (image != null) {
      //print("image was not null");
      return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          width: 3 * size,
          height: 4 * size,
          //decoration: BoxDecoration(
          //  color: Colors.orange,
          //    borderRadius: BorderRadius.all(Radius.circular(20))
          //),
          child: Stack(
            children: [
              SizedBox(
                width: 3 * size,
                height: 4 * size,
                child: FittedBox(fit: BoxFit.fitWidth, child: image!),
              ),
              //FittedBox(child: Image.file(image!), fit: BoxFit.fill),
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: "delete photo",
                onPressed: () {
                  deleteImageCallback(index);
                },
              )
            ],
          ),
        ),
      );
    } else {
      if (required) {
        return Container(
          width: 3 * size,
          height: 4 * size,
          decoration: const BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Stack(
            children: [
              //Text('${widget.index.value.toString()}'),
              Center(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: IconButton(
                      onPressed: () async {
                        await pickImage(index);
                      },
                      color: Colors.lightBlueAccent,
                      icon: const Icon(Icons.add)),
                ),
              ),
            ],
          ),
        );
      } else {
        //print("image does not exist.");
        //if it is not required, thus it should be a dotted border
        return Container(
          width: 3 * size,
          height: 4 * size,
          child: DottedBorder(
            strokeWidth: 2,
            dashPattern: [6, 6],
            color: Colors.lightBlueAccent,
            borderType: BorderType.RRect,
            radius: const Radius.circular(20.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: IconButton(
                          onPressed: () async {
                            if(mandatoryFilled){ //only allow them to pick these ones if the mandatory ones are already filled.
                              await pickImage(index);
                            }else{
                              Fluttertoast.showToast(
                                  msg: "You have to add the mandatory photos first!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.pinkAccent,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                          },
                          color: Colors.lightBlueAccent,
                          icon: const Icon(Icons.add)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
  }
}
