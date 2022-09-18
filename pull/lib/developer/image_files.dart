import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

List<String> dev_image_urls = [
  "https://images.pexels.com/photos/3866555/pexels-photo-3866555.png?cs=srgb&dl=pexels-clara-ngo-3866555.jpg&fm=jpg",
  "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg",
  "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?cs=srgb&dl=pexels-andrea-piacquadio-774909.jpg&fm=jpg",
  "https://images.pexels.com/photos/1024311/pexels-photo-1024311.jpeg?cs=srgb&dl=pexels-mentatdgt-1024311.jpg&fm=jpg",
  "https://images.pexels.com/photos/532220/pexels-photo-532220.jpeg?cs=srgb&dl=pexels-pixabay-532220.jpg&fm=jpg",
  "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?cs=srgb&dl=pexels-creation-hill-1681010.jpg&fm=jpg",
  "https://images.pexels.com/photos/38554/girl-people-landscape-sun-38554.jpeg?cs=srgb&dl=pexels-pixabay-38554.jpg&fm=jpg",
  "https://images.pexels.com/photos/1587009/pexels-photo-1587009.jpeg?cs=srgb&dl=pexels-moose-photos-1587009.jpg&fm=jpg",
  "https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg?cs=srgb&dl=pexels-chloe-1043474.jpg&fm=jpg",
  "https://images.pexels.com/photos/775358/pexels-photo-775358.jpeg?cs=srgb&dl=pexels-spencer-selover-775358.jpg&fm=jpg",
];