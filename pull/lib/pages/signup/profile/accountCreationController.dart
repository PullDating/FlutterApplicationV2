import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull/models/profile.dart';
import 'package:pull/network/pull_api/repository.dart';
import 'package:pull/pages/signup/filters/filters.dart';
import 'package:pull/pages/signup/profile/biography.dart';
import 'package:pull/pages/signup/profile/birth_date.dart';
import 'package:pull/pages/signup/profile/body_type.dart';
import 'package:pull/pages/signup/profile/dating_goal.dart';
import 'package:pull/pages/signup/profile/gender.dart';
import 'package:pull/pages/signup/profile/height.dart';
import 'package:pull/pages/signup/profile/name.dart';
import 'package:pull/pages/signup/profile/photos.dart';
import 'package:pull/providers/account_setup/biography.dart';
import 'package:pull/providers/account_setup/birthdate.dart';
import 'package:pull/providers/account_setup/body_type.dart';
import 'package:pull/providers/account_setup/dating_goal.dart';
import 'package:pull/providers/account_setup/filters.dart';
import 'package:pull/providers/account_setup/gender.dart';
import 'package:pull/providers/account_setup/height.dart';
import 'package:pull/providers/account_setup/name.dart';
import 'package:pull/providers/account_setup/photos.dart';
import 'package:pull/providers/filter.dart';
import 'package:pull/providers/network/uuid.dart';
import 'package:location/location.dart';
import 'package:pull/providers/profile.dart';

class AccountCreationController extends ConsumerStatefulWidget {
  const AccountCreationController({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  ConsumerState<AccountCreationController> createState() => _AccountCreationControllerState();
}

class _AccountCreationControllerState extends ConsumerState<AccountCreationController> {

  final List<Tab> navBarItems = const [
    Tab(icon: Icon(Icons.drive_file_rename_outline),), //name
    Tab(icon: Icon(Icons.transgender),), //gender
    Tab(icon: Icon(Icons.flag)), //dating goal
    Tab(icon: Icon(Icons.date_range)), //birthdate
    Tab(icon: Icon(Icons.photo)), //photos
    Tab(icon: Icon(Icons.height)), //height
    Tab(icon: Icon(Icons.man)), //body type
    Tab(icon: Icon(Icons.text_format)), //biography
    Tab(icon: Icon(Icons.filter_alt)) //filters
  ];

  ///submits the values to the database and redirects. Should ONLY be called after it has been
  ///checked that the values from the account creation providers are valid.
  _submit() async{
    PullRepository repo = PullRepository(ref.read);

    Location location = Location();
    LocationData locationData = await location.getLocation();
    //call the post profile endpoint
    try {
      double? longitude = locationData.longitude;
      double? latitude = locationData.latitude;
      if(latitude == null || longitude == null){
        throw Exception("Couldn't get valid location data for longitude and latitude.");
      }
      Profile profileToUpload = Profile(
        biography: ref.read(accountCreationBiographyProvider)!,
        birthdate: ref.read(accountCreationBirthDateProvider)!,
        bodyType: ref.read(accountCreationBodyTypeProvider)!,
        datingGoal: ref.read(accountCreationDatingGoalProvider)!,
        gender: ref.read(accountCreationGenderProvider)!,
        height: ref.read(accountCreationHeightProvider),
        images: ref.read(accountCreationPhotosProvider),

        //todo get current location

        // ref.read(AccountCreationProvider.notifier).setLongitude(_locationData.longitude!);
        // ref.read(AccountCreationProvider.notifier).setLatitude(_locationData.latitude!);
        latitude: longitude,
        longitude: latitude,
        name: ref.read(accountCreationNameProvider)!,
        uuid: ref.read(uuidProvider)!,
      );
      await repo.createProfile(
          profileToUpload
      );
      //call the post filters endpoint
      try{
        //set the filter and profile providers for general purpose use
        await repo.createFilter(ref.read(accountCreationFilterProvider));
        ref.read(filterProvider.notifier).set(ref.read(accountCreationFilterProvider));
        ref.read(profileProvider.notifier).set(profileToUpload);

        //redirect to home page.
        context.go('/home');
      }catch(e){
        print(e);
        throw Exception("Couldn't send the create filter request.");
      }

    } catch (e) {
      print(e);
      throw Exception("Couldn't send the create profile request.");
    }
  }

  ///checks all the profile creation providers to see if their values are valid for the backend.
  bool _checkIfProfileSetupCompleted(){

    //check the relevant ones to make sure they have selected a value
    if(
    ref.read(accountCreationBiographyProvider) == null
    || ref.read(accountCreationBirthDateProvider) == null
    || ref.read(accountCreationBodyTypeProvider) == null
    || ref.read(accountCreationDatingGoalProvider) == null
    || ref.read(accountCreationGenderProvider) == null
    || ref.read(accountCreationNameProvider) == null
    ) {
      return false;
    }

    //todo check that they have the correct number of photos
    //todo check that they have set the name to a valid value
    //check that their selected birthdate makes them at least 18 years old
    return true;
  }


  @override
  Widget build(BuildContext context) {

    //need to watch the providers to update when they change
    ref.watch(accountCreationFilterProvider);
    ref.watch(accountCreationPhotosProvider);
    ref.watch(accountCreationNameProvider);
    ref.watch(accountCreationHeightProvider);
    ref.watch(accountCreationGenderProvider);
    ref.watch(accountCreationDatingGoalProvider);
    ref.watch(accountCreationBodyTypeProvider);
    ref.watch(accountCreationBirthDateProvider);
    ref.watch(accountCreationBiographyProvider);

    //see if all the providers are done and have valid values
    bool completed = _checkIfProfileSetupCompleted();

    return DefaultTabController(
      length: navBarItems.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const NamePage(),
                        const GenderPage(),
                        const DatingGoalPage(),
                        const BirthDatePage(),
                        const PhotoPage(),
                        const HeightPage(),
                        const BodyTypePage(),
                        const BiographyPage(),
                        FilterPage(),
                      ],
                    ),
                  ),
                  Container(
                    height: 25,
                    child: (completed)? ElevatedButton(
                      child: const Icon(Icons.check),
                      onPressed: () => _submit(),
                    ) : Container(),
                  ),
                ],
              ),
            );
          }
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).primaryColor,
          child: TabBar(
            tabs: navBarItems,
          ),
        ),
      ),
    );
  }
}
