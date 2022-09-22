import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull/models/person.dart';
import 'package:pull/models/profile.dart';
import 'package:pull/pages/signup/profile/photos.dart';
import 'package:pull/providers/developer_mode.dart';
import 'package:pull/providers/filters/valid_bodyTypes.dart';
import 'package:pull/providers/filters/valid_datingGoals.dart';
import 'package:pull/providers/filters/valid_genders.dart';
import 'package:pull/providers/max_biography_characters.dart';
import 'package:pull/providers/max_profile_image_count.dart';
import 'package:pull/providers/min_profile_image_count.dart';
import 'package:pull/providers/profile.dart';
import 'package:pull/ui_widgets/filter_list.dart';
import 'package:pull/ui_widgets/swipe_card.dart';

//todo modify this, since it is from the older app.

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  late Profile profile;

  late TextEditingController biographyController = TextEditingController();

  /// Stores the reordering information for the profile update call.
  /// The key is the new position in the update photo list.
  /// The value is the old position from the photo list
  /// If the old value is -1 that means that it is a newly updated photo.
  late List<int> reorderPhotos;

  //contains the list of valid options that they can have.
  late List<String> bodyTypeOptionNames = [];
  late List<String> genderOptionNames = [];
  late List<String> datingGoalOptionNames = [];

  @override
  void initState() {
    super.initState();

    profile = ref.read(profileProvider)!.copyWith();

    //set the option names for display.
    //bodytype options
    for (int i = 0; i < ref.read(validBodyTypesProvider).length; i++) {
      bodyTypeOptionNames.add(ref.read(validBodyTypesProvider)[i].item2);
    }

    //gender
    for (int i = 0; i < ref.read(validGendersProvider).length; i++) {
      genderOptionNames.add(ref.read(validGendersProvider)[i].item2);
    }

    //dating goal
    for (int i = 0; i < ref.read(validDatingGoalsProvider).length; i++) {
      datingGoalOptionNames.add(ref.read(validDatingGoalsProvider)[i].item2);
    }

    biographyController.text =
    (profile.biography == null) ? '' : profile.biography;

    reorderPhotos = [];
    for (int i = 0; i < profile.images.length; i++) {
      reorderPhotos.add(i);
    }
  }

  //they it should update the database, and then navigate back to /home/profile.
  Future<void> submit() async {

    if(!ref.read(developerModeProvider)) {
      // print("submit pressed");
      // print("reorder photos:" + reorderPhotos.toString());
      // print("profile images: " + profileImages.toString());
      // profile = profile.copyWith(biography: biographyController.text);
      //
      // //send a request to the database to update the profile based on the profile that is here
      // try {
      //   PullRepository repo = PullRepository(ref.read);
      //   await repo.updateProfile(ref, profile, profileImages, reorderPhotos).then((value) => {
      //     context.go('/home/profile')
      //   });
      // } on TimeoutException catch (e) {
      //   print('Timeout');
      //   Fluttertoast.showToast(
      //       msg: "You're having connectivity issues, please check connection and reset your app.",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.CENTER,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.red,
      //       textColor: Colors.white,
      //       fontSize: 16.0
      //   );
      // } on Error catch (e) {
      //   print('Error: $e');
      // }
    } else {
      //if in developer mode.
      print("submit pressed");

      context.go('/home?index=2');
    }
  }

  cancel() {
    context.go('/home?index=2');
  }

  _reorderPhotos(int oldIndex, int newIndex) {
    setState(() {
      //check to make sure they aren't arranging the empty ones

      if(profile.images[oldIndex] == null || oldIndex >= profile.images.length){
        print("cannot move an empty image tile.");
        return;
      }
      List<File?> tempImages = List.from(profile.images);
      File? temp = tempImages[oldIndex];
      //remove at the old index
      tempImages.removeAt(oldIndex);

      //remove from reorderPhotos
      int reorderTemp = reorderPhotos.removeAt(oldIndex);

      //insert at the new index
      tempImages.insert(newIndex, temp);

      //add to reorderPhotos
      reorderPhotos.insert(newIndex, reorderTemp);

      //set the profile's images to the rearranged images.
      profile = profile.copyWith(images: tempImages);

      //handle the update to reorder photos
      //It should get the new old location from the previous old location
    });
  }

  //TODO keep track of the added photos for the api.
  _pickPhoto(int index) async {
    try {
      print("trying to pick image.");
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      //check to make sure it didn't pick an empty file, or fail.
      if (image == null){
        print("image was null, didn't pick image.");
        return;
      }

      //store a temporary list while the rearranging is done, as well as some temp variables.
      List<File?> tempimages = List.from(profile.images);

      //check to make sure that is is within the valid range of indexes.
      if(index < ref.read(maxProfileImageCountProvider) && index >= 0){
        if(tempimages.length <= index){
          //need to append an empty value first
          tempimages.add(File(image.path));
        } else {
          //otherwise, just set the right place to the new value.
          tempimages[index] = File(image.path);
        }

        //handle the add to reorderPhotos
        reorderPhotos.insert(index, -1);

        print("reorderPhotos");
        print(reorderPhotos);

        //set state with the new values for the photos.
        setState(() {
          profile = profile.copyWith(
              images: tempimages,
          );
        });
      } else {
        throw "The index you tried to replace is out of range";
      }

      //profileImages.images[index] = File(image.path);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  //TODO keep track of the deleted photos for the api.
  _deletePhoto(int index) {
    print("_deletePhoto pressed");
    setState((){
      List<File?> tempimages = List.from(profile.images);
      tempimages.removeAt(index);
      reorderPhotos.removeAt(index);

      //copy with the new image list.
      profile = profile.copyWith(
          images: tempimages,
      );

      print("reorderPhotos");
      print(reorderPhotos);
    });

  }

  _datingGoalPressed(int index){
    print("dating goal pressed with index: ${index}");
    setState(() {
      profile = profile.copyWith(datingGoal: ref.read(validDatingGoalsProvider)[index].item1);
    });
  }

  _bodyTypePressed(int index){
    print("bodyType pressed with index: ${index}");
    setState(() {
      profile = profile.copyWith(bodyType: ref.read(validBodyTypesProvider)[index].item1);
    });
  }

  _genderPressed(int index){
    print("gender pressed with index: ${index}");
    setState(() {
      profile = profile.copyWith(gender: ref.read(validGendersProvider)[index].item1);
    });
  }

  @override
  Widget build(BuildContext context) {
    //contains a list of the strings that are selected by the user
    List<bool> datingGoalChecked = [];
    List<bool> bodyTypeChecked = [];
    List<bool> genderChecked = [];

    for(int i = 0 ; i < ref.read(validBodyTypesProvider).length; i++){
      if(ref.read(validBodyTypesProvider)[i].item1 == profile.bodyType){
        bodyTypeChecked.add(true);
      } else {
        bodyTypeChecked.add(false);
      }
    }

    //gender
    for(int i = 0 ; i < ref.read(validGendersProvider).length; i++){
      if(ref.read(validGendersProvider)[i].item1 == profile.gender){
        genderChecked.add(true);
      } else {
        genderChecked.add(false);
      }
    }

    //dating goal
    for(int i = 0 ; i < ref.read(validDatingGoalsProvider).length; i++){
      if(ref.read(validDatingGoalsProvider)[i].item1 == profile.datingGoal){
        datingGoalChecked.add(true);
      } else {
        datingGoalChecked.add(false);
      }
    }

    //construct a person to show on the display part from the profile
    int age;
    DateTime now = DateTime.now();
    try {
      age = now
          .difference(profile.birthdate)
          .inDays ~/ 365;
    } catch (e) {
      print(e);
      throw("age cast failed");
    }

    Person person = Person(
      age: age,
      name: profile.name,
      distance: 0,
      images: profile.images,
      uuid: profile.uuid,
    );

    final availableHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        kTextTabBarHeight;

    var tiles = <ImageThumbnail>[];

    try {
      for (int i = 0; i < ref.read(minProfileImageCountProvider); i++) {
        if (profile.images.length > i) {
          tiles.add(ImageThumbnail(
            image: Image.file(profile.images[i]!),
            pickImage: _pickPhoto,
            deleteImageCallback: _deletePhoto,
            index: i,
            required: true,
            mandatoryFilled: profile.images.length >= ref.read(minProfileImageCountProvider),
          ));
        } else {
          tiles.add(ImageThumbnail(
            image: null,
            pickImage: _pickPhoto,
            deleteImageCallback: _deletePhoto,
            index: i,
            required: true,
            mandatoryFilled: profile.images.length >= ref.read(minProfileImageCountProvider),
          ));
        }
      }

      //for the not mandatory to be filled.
      for (int i = ref.read(minProfileImageCountProvider); i < min(
          max(ref.read(minProfileImageCountProvider) + 1, profile.images.length + 1),
          ref.read(maxProfileImageCountProvider)); i++) {
        if (profile.images.length > i) {
          tiles.add(ImageThumbnail(
            image: Image.file(profile.images[i]!),
            pickImage: _pickPhoto,
            deleteImageCallback: _deletePhoto,
            index: i,
            required: false,
            mandatoryFilled: profile.images.length >= ref.read(minProfileImageCountProvider),
          ));
        } else {
          tiles.add(ImageThumbnail(
            image: null,
            pickImage: _pickPhoto,
            deleteImageCallback: _deletePhoto,
            index: i,
            required: false,
            mandatoryFilled: profile.images.length >= ref.read(minProfileImageCountProvider),
          ));
        }
      }
    } catch (e) {
      print(e);
      throw Exception("There was a problem trying to fill the profile fields");
    }

    return Material(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const TabBar(
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: "Edit",
                    ),
                    Tab(
                      text: "Preview",
                    ),
                  ],
                ),
                //this contains the update two tabs and all the logic
                Container(
                  height: availableHeight * 0.95,
                  child: TabBarView(
                    children: [
                      //edit
                      Container(
                        child: ListView(
                          children: [
                            //edit photos.
                            PhotoField(
                              onReorder: _reorderPhotos,
                              tiles: tiles,
                            ),
                            //edit biography
                            BiographyBox(
                              maxCharacters: ref.read(maxBiographyLengthProvider),
                              controller: biographyController,
                            ),
                            //edit dating goals
                            FilterListItem(
                              icon: const Icon(Icons.search),
                              title: "Dating Goal",
                              widget: SingleSelectRow(
                                onPressed: (int index) {
                                  _datingGoalPressed(index);
                                },
                                checked: datingGoalChecked,
                                optionNames: datingGoalOptionNames,
                              ),
                            ),
                            FilterListItem(
                              icon: const Icon(Icons.man),
                              title: "Body Type",
                              widget: SingleSelectRow(
                                onPressed: (int index) {
                                  _bodyTypePressed(index);
                                },
                                checked: bodyTypeChecked,
                                optionNames: bodyTypeOptionNames,
                              ),
                            ),
                            FilterListItem(
                              icon: const Icon(Icons.transgender),
                              title: "Gender",
                              widget: SingleSelectRow(
                                onPressed: (int index) {
                                  _genderPressed(index);
                                },
                                checked: genderChecked,
                                optionNames: genderOptionNames,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //preview
                      Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: PullSwipeCard(
                                person: person,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //this serves as a bottom app bar for saving or cancelling.
                Container(
                  color: Colors.lightBlueAccent,
                  height: availableHeight * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => {cancel()},
                      ),
                      IconButton(
                        icon: Icon(Icons.done),
                        onPressed: () => {submit()},
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PhotoField extends StatelessWidget {
  PhotoField({
    Key? key,
    required this.onReorder,
    required this.tiles,
  }) : super(key: key);

  Function(int, int) onReorder;
  List<Widget> tiles;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: WrapList(
                  onReorder: onReorder,
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

class BiographyBox extends StatelessWidget {
  BiographyBox({
    Key? key,
    required this.maxCharacters,
    required this.controller,
  }) : super(key: key);

  int maxCharacters;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.85,
      child: Container(
        child: Column(
          children: [
            TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(maxCharacters),
              ],
              minLines: 1,
              maxLines: 5,
              obscureText: false,
              controller: controller,
              onChanged: (String value) {
                controller.text = value;
                controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));

                print(
                    "Current number of characters: ${controller.text.characters.length}");
              },
            ),
            Text(
              (controller.text.characters.length >= 300)
                  ? "Max Characters Reached!"
                  : "${controller.text.characters.length}/$maxCharacters",
              style: TextStyle(
                color: (controller.text.characters.length >= 300)
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}

class SingleSelectRow extends StatelessWidget {
  SingleSelectRow(
      {
        Key? key,
        required this.checked,
        required this.onPressed(int index),
        required this.optionNames,
      }) : super(key: key);

  //String is the name, bool is whether it is selected or not.

  //these should have the same length
  //TODO convert these to a tuple.
  List<String> optionNames;
  List<bool> checked;

  Function onPressed;

  @override
  Widget build(BuildContext context) {

    //generate the children widgets.
    List<Widget> displayWidgets = [];
    for(int i = 0; i < checked.length; i++){
      displayWidgets.add(
        SizedBox(
          height: 30,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: ElevatedButton(
              onPressed: () {
                onPressed(i);
              },
              child: Text(optionNames[i]),
              style: ElevatedButton.styleFrom(
                primary: (checked[i] == false) ? Colors.grey : Colors.lightBlueAccent,
              ),
            ),
          ),
        ),
      );
    }
    return Expanded(
      child: Wrap(
        spacing: 5,

        children: displayWidgets,
      ),
    );
  }
}