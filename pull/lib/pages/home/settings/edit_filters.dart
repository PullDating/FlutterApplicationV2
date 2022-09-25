import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull/models/filter.dart';
import 'package:pull/providers/developer_mode.dart';
import 'package:pull/providers/filter.dart';
import 'package:pull/ui_widgets/filter_list.dart';

class EditFiltersPage extends ConsumerStatefulWidget {
  const EditFiltersPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<EditFiltersPage> createState() => _EditFiltersPageState();
}



class _EditFiltersPageState extends ConsumerState<EditFiltersPage> {

  onCancel(BuildContext context){
    print("onCancel done");
    context.go('/home?index=2');
  }

  onDone(BuildContext context){
    print("onDone pressed");
    if(!ref.read(developerModeProvider)){
      //todo add the backend requuest to update the database, and update the providers.
    }
    context.go('/home?index=2');
  }



  bool metricImperial = false; //to use metric or imperial

  late Filter filters;

  @override
  void initState() {
    super.initState();
    filters = ref.read(filterProvider)!.copyWith();
    print("filters populated.");
  }

  _ageChanged(int min, int max){
    setState(() {
      filters = filters.copyWith(maxAge: max, minAge: min);
    });
  }

  _heightChanged(int min, int max){
    setState(() {
      filters = filters.copyWith(maxHeight: max, minHeight: min);
    });
  }

  _maxDistanceChanged(int value){
    setState(() {
      filters = filters.copyWith(maxDistance: value);
    });
  }

  _womenChecked(){
    setState(() {
      filters = filters.copyWith(genderWoman: !filters.genderWoman);
    });
  }

  _menChecked(){
    setState(() {
      filters = filters.copyWith(genderMan: !filters.genderMan);
    });
  }

  _nonBinaryChecked() {
    setState(() {
      filters = filters.copyWith(genderNonBinary: !filters.genderNonBinary);
    });
  }

  _obeseChecked(){
    setState(() {
      filters = filters.copyWith(btObese: !filters.btObese);
    });
  }

  _heavyChecked(){
    setState(() {
      filters = filters.copyWith(btHeavy: !filters.btHeavy);
    });
  }

  _muscularChecked(){
    setState(() {
      filters = filters.copyWith(btMuscular: !filters.btMuscular);
    });
  }

  _averageChecked(){
    setState(() {
      filters = filters.copyWith(btAverage: !filters.btAverage);
    });
  }

  _leanChecked(){
    setState(() {
      filters = filters.copyWith(btLean: !filters.btLean);
    });

  }

  _cancel(BuildContext context){
    print("cancel pressed");
    context.go('/home?index=2');
  }
  _done(BuildContext context){
    print("done pressed");
    context.go('/home?index=2');
  }

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Scaffold(
        body: FilterList(
          displayFilter: filters,
          ageChanged: (min, max) => _ageChanged(min, max),
          heightChanged: (min, max) => _heightChanged(min, max),
          maxDistanceChanged: (value) => _maxDistanceChanged(value),
          womenChecked: () => _womenChecked(),
          menChecked: () => _menChecked(),
          nonBinaryChecked: () => _nonBinaryChecked(),
          obeseChecked: () => _obeseChecked(),
          heavyChecked: () => _heavyChecked(),
          muscularChecked: () => _muscularChecked(),
          averageChecked: () => _averageChecked(),
          leanChecked: () => _leanChecked(),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.cancel),
                onPressed:() => _cancel(context),
              ),
              IconButton(
                icon: Icon(Icons.done),
                onPressed: () => _done(context),
              ),
            ],
          ),
        ),
      ),
    );

    // return Material(
    //   child: Scaffold(
    //     body: SafeArea(
    //       child: Column(
    //         children: [
    //           Container(
    //             height: availableHeight*0.9,
    //             child: ListView(
    //               children: [
    //                 SizedBox(height: 20,),
    //                 FilterListItem(icon: Icon(Icons.transgender),title: "Gender(s)",
    //                     widget: Row(
    //                       children: [
    //                         SizedBox(
    //                           height: 30,
    //                           child: FittedBox(
    //                             fit: BoxFit.fitHeight,
    //                             child: ElevatedButton(
    //                               onPressed: () {
    //                                 setState(() {
    //                                   filters = filters.copyWith(genderMan: !filters.genderMan);
    //                                 });
    //                               }, child: Text('Men'),
    //                               style: ElevatedButton.styleFrom(
    //                                 primary: (filters.genderMan == false) ? Colors.grey : Colors.lightBlueAccent,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           height: 30,
    //                           child: FittedBox(
    //                             fit: BoxFit.fitHeight,
    //                             child: ElevatedButton(onPressed: () {
    //                               setState(() {
    //                                 filters = filters.copyWith(genderWoman: !filters.genderWoman);
    //                               });
    //
    //                             }, child: Text('Women'),
    //                               style: ElevatedButton.styleFrom(
    //                                 primary: (filters.genderWoman == false) ? Colors.grey : Colors.lightBlueAccent,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           height: 30,
    //                           child: FittedBox(
    //                             fit: BoxFit.fitHeight,
    //                             child: ElevatedButton(onPressed: () {
    //                               setState(() {
    //                                 setState(() {
    //                                   filters = filters.copyWith(genderNonBinary: !filters.genderNonBinary);
    //                                 });
    //                               });
    //                             }, child: Text('Non-Binary'),
    //                               style: ElevatedButton.styleFrom(
    //                                 primary: (filters.genderNonBinary == false) ? Colors.grey : Colors.lightBlueAccent,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(
    //                             height: 30,
    //                             child: FittedBox(
    //                                 fit: BoxFit.fitHeight,
    //                                 child: ElevatedButton(onPressed: () {}, child: Icon(Icons.add))))
    //                       ],
    //                     )
    //                 ),
    //                 FilterListItem(icon: Icon(Icons.access_time_outlined),title: "Age",
    //                     widget: SizedBox(
    //                       width: 280,
    //                       child: RangeSlider(
    //                         min: 18,
    //                         max: 120,
    //                         divisions: 120-18,
    //                         values: RangeValues(filters.minAge.toDouble(),filters.maxAge.toDouble()),
    //                         onChanged: (values) {
    //                           setState(() {
    //                             filters.copyWith(minAge: values.start.toInt(), maxAge: values.end.toInt());
    //                           });
    //                         },
    //                         labels: RangeLabels(filters.minAge.round().toString(),filters.maxAge.round().toString()),
    //                       ),
    //                     )
    //                 ),
    //                 FilterListItem(icon: Icon(Icons.social_distance),title: "Distance",
    //                     widget: SizedBox(
    //                       width: 280,
    //                       child: Slider(
    //                         min: 0,
    //                         max: 100,
    //                         divisions: 100,
    //                         value: filters.maxDistance.toDouble(),
    //                         onChanged: (value) {
    //                           setState(() {
    //                             filters = filters.copyWith(maxDistance: value.toInt());
    //                             //print(filters.maxDistance);
    //                           });
    //                         },
    //                         label: (metricImperial == false) ? "${filters.maxDistance.round().toString()} km" : "${(filters.maxDistance*0.621371).round().toString()} miles",
    //                       ),
    //                     )
    //                 ),
    //                 FilterListItem(icon: Icon(Icons.height),title: "Height",
    //                     widget: SizedBox(
    //                       width: 280,
    //                       child: RangeSlider(
    //                         min: 55,
    //                         max: 275,
    //                         divisions: 275-55,
    //                         values: RangeValues(filters.minHeight.toDouble(),filters.maxHeight.toDouble()),
    //                         onChanged: (values) {
    //                           setState(() {
    //                             filters = filters.copyWith(minHeight: values.start.toInt(), maxHeight: values.end.toInt());
    //                           });
    //                         },
    //                         labels: RangeLabels((metricImperial == false)? "${filters.minHeight.round()} cm" : "${(filters.minHeight~/30.48).round().toString()}\'${(((filters.minHeight / 30.48)-(filters.minHeight ~/ 30.48))*12).toInt().toString()}\""
    //                             , (metricImperial == false)? "${filters.maxHeight.round()} cm" : "${(filters.maxHeight~/30.48).round().toString()}\'${(((filters.maxHeight / 30.48)-(filters.maxHeight ~/ 30.48))*12).toInt().toString()}\"" ),
    //                       ),
    //                     )
    //                 ),
    //                 FilterListItem(icon: Icon(Icons.man_outlined),title: "BodyType",
    //                     widget: Flexible(
    //                       flex: 5,
    //                       child: Wrap(
    //                         spacing: 8.0, // gap between adjacent chips
    //                         runSpacing: 4.0, // gap between lines
    //                         children: [
    //                           SizedBox(
    //                             height: 30,
    //                             child: FittedBox(
    //                               fit: BoxFit.fitHeight,
    //                               child: ElevatedButton(
    //                                 onPressed: () {
    //                                   setState(() {
    //                                     filters = filters.copyWith(btObese: !filters.btObese);
    //                                   });
    //                                 }, child: Text('Obese'),
    //                                 style: ElevatedButton.styleFrom(
    //                                   primary: (filters.btObese == false) ? Colors.grey : Colors.lightBlueAccent,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: 30,
    //                             child: FittedBox(
    //                               fit: BoxFit.fitHeight,
    //                               child: ElevatedButton(onPressed: () {
    //                                 setState(() {
    //                                   filters = filters.copyWith(btHeavy: !filters.btHeavy);
    //                                 });
    //
    //                               }, child: Text('Heavy'),
    //                                 style: ElevatedButton.styleFrom(
    //                                   primary: (filters.btHeavy == false) ? Colors.grey : Colors.lightBlueAccent,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: 30,
    //                             child: FittedBox(
    //                               fit: BoxFit.fitHeight,
    //                               child: ElevatedButton(onPressed: () {
    //                                 setState(() {
    //                                   setState(() {
    //                                     filters = filters.copyWith(btMuscular: !filters.btMuscular);
    //                                   });
    //                                 });
    //                               }, child: Text('Muscular'),
    //                                 style: ElevatedButton.styleFrom(
    //                                   primary: (filters.btMuscular == false) ? Colors.grey : Colors.lightBlueAccent,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: 30,
    //                             child: FittedBox(
    //                               fit: BoxFit.fitHeight,
    //                               child: ElevatedButton(onPressed: () {
    //                                 setState(() {
    //                                   setState(() {
    //                                     filters = filters.copyWith(btAverage: !filters.btAverage);
    //                                   });
    //                                 });
    //                               }, child: Text('Average'),
    //                                 style: ElevatedButton.styleFrom(
    //                                   primary: (filters.btAverage == false) ? Colors.grey : Colors.lightBlueAccent,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: 30,
    //                             child: FittedBox(
    //                               fit: BoxFit.fitHeight,
    //                               child: ElevatedButton(onPressed: () {
    //                                 setState(() {
    //                                   setState(() {
    //                                     filters = filters.copyWith(btLean: !filters.btLean);
    //                                   });
    //                                 });
    //                               }, child: Text('Lean'),
    //                                 style: ElevatedButton.styleFrom(
    //                                   primary: (filters.btLean == false) ? Colors.grey : Colors.lightBlueAccent,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     )
    //                 ),
    //                 ListTile(
    //                   //leading: Icon(Icons.man_outlined),
    //                   title: Text("You will only see people who match these filters, and you will only be shown to people who's filters you match."),
    //                 ),
    //                 ListTile(
    //                   //leading: Icon(Icons.man_outlined),
    //                   title: Text('Their dating goal will match your selection.'),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Container(
    //             height: availableHeight*0.1,
    //             color: Colors.lightBlueAccent,
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 IconButton(
    //                   icon: const Icon(Icons.cancel),
    //                   onPressed: () => onCancel(context),
    //                 ),
    //                 Row(
    //                   children: [
    //                     Text("Metric"),
    //                     Switch(value: metricImperial, onChanged: (value) {
    //                       setState(() {
    //                         metricImperial = value;
    //                       });
    //                     },
    //                       activeColor: Colors.pinkAccent,
    //                       inactiveTrackColor: Color.fromRGBO(38, 38, 38, 0.4),
    //                       activeTrackColor: Color.fromRGBO(38, 38, 38, 0.4),
    //                       inactiveThumbColor: Colors.blue,
    //                     ),
    //                     Text("Imperial")
    //                   ],
    //                 ),
    //                 IconButton(
    //                   icon: Icon(Icons.done),
    //                   onPressed: () => onDone(context),
    //                 )
    //               ],
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

class FilterListItem extends StatelessWidget {
  final Icon icon;
  final Widget widget;
  String? title;
  FilterListItem({
    Key? key,
    required this.icon,
    required this.widget,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            Container(
              width: 10,
            ),
            (title != null) ? Text(title!) : Text(''),
            Spacer(),
            widget,
          ],
        ),
      ),
    );
  }
}
