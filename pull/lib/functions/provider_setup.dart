
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/models/filter.dart';
import 'package:pull/models/profile.dart';
import 'package:pull/network/pull_api/repository.dart';
import 'package:pull/providers/filter.dart';
import 'package:pull/providers/profile.dart';

///populate the providers that handle basic settings. The majority should come from the local
///storage (hive) but it will poll the database if necessary.
setupBasicProviders(WidgetRef ref) async {
  print("setting up Basic Providers");
  //todo add the logic to setups the basic providers
  //stored values that are out of date should be updated as well....

  //todo get age max and min in api call
  //todo get height max and min in api call
  //todo get min and max profile image count in api call
  //todo get the max number of concurrent matches in api call
  //todo get the max number of characters in a biography
  //todo get the max distance for the filters
  //todo get the unit system set correctly (metric/imperial) with provider.

}

setupUserProviders(WidgetRef ref) async {
  print("Setting up user providers");
  PullRepository repo = PullRepository(ref.read);

  Profile profile = await repo.getProfile(null);
  ref.read(profileProvider.notifier).set(profile);

  //todo add the logic to get the accountPausedProvider from the api.

  //todo add the logic to get the list of their matches


  print("attempting to set up filter provider");
  try {
    //todo add the logic to get their filters
    Filter filter = await repo.getFilter();
    ref.read(filterProvider.notifier).set(filter);
    Filter test = ref.read(filterProvider)!;
    print("testing filters: max distance");
    print(test.maxDistance);
  } catch (e) {
    print(e);
  }
}