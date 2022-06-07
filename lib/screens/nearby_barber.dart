// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
// import 'package:gromify/widgets/google_map.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late ScrollController scrollController;
//   double height = 0.0;
//
//   ///The controller of sliding up panel
//   SlidingUpPanelController panelController = SlidingUpPanelController();
//
//   @override
//   void initState() {
//     scrollController = ScrollController();
//     scrollController.addListener(() {
//       if (scrollController.offset >=
//           scrollController.position.maxScrollExtent &&
//           !scrollController.position.outOfRange) {
//         panelController.expand();
//       } else if (scrollController.offset <=
//           scrollController.position.minScrollExtent &&
//           !scrollController.position.outOfRange) {
//         panelController.anchor();
//       } else {}
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Scaffold(
//           body: SafeArea(child: GoogleMapWidget()),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 50.0),
//           child: SlidingUpPanelWidget(
//             child: Container(
//               decoration: const ShapeDecoration(
//                 color: Colors.white,
//                 shadows: [
//                   BoxShadow(
//                       blurRadius: 5.0,
//                       spreadRadius: 2.0,
//                       color: Color(0x11000000))
//                 ],
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20.0),
//                     topRight: Radius.circular(20.0),
//                   ),
//                 ),
//               ),
//               child: Column(
//                 children: <Widget>[
//                   const SizedBox(
//                     height: 5.0,
//                   ),
//                   Container(
//                     width: 40.0,
//                     height: 6.0,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                   ),
//                   whereToButton(),
//                   const Spacer(),
//                   InkWell(
//                     onTap: (){
//                       panelController.collapse();
//                       setState(() {
//                         height = 0.0;
//                       });
//                     },
//                     child: Container(
//                       decoration: const BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey,
//                               spreadRadius: 0.0,
//                               blurRadius: 3.0,
//                               offset: Offset(0.0, -1.0),
//                             ),
//                           ]
//                       ),
//                       width: MediaQuery.of(context).size.width * 1.0,
//                       padding: const EdgeInsets.all(10.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(CupertinoIcons.map_pin),
//                           SizedBox(
//                             width: 8.0,
//                           ),
//                           Text('Choose on map',style: TextStyle(
//                             fontSize: 16,
//                           ),),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//                 mainAxisSize: MainAxisSize.min,
//               ),
//             ),
//             controlHeight: 100.0,
//             anchor: 0.1,
//             panelController: panelController,
//             onTap: () {
//               ///Customize the processing logic
//               if (SlidingUpPanelStatus.expanded == panelController.status) {
//                 panelController.collapse();
//               } else {
//                 panelController.expand();
//               }
//             },
//             enableOnTap: true, //Enable the onTap callback for control bar.
//             onStatusChanged: (status){
//               setState(() {
//                 status = status;
//               });
//             },
//             dragDown: (details) {
//               print('dragDown');
//               if(panelController.status == SlidingUpPanelStatus.collapsed){
//                 setState(() {
//                   height = MediaQuery.of(context).size.height * 0.7;
//                 });
//               }
//             },
//             dragStart: (details) {
//               print('dragStart');
//               print(details.localPosition.dy);
//               print(details.globalPosition.dy);
//             },
//             dragCancel: () {
//               print('dragCancel');
//               if(panelController.status == SlidingUpPanelStatus.expanded){
//                 setState(() {
//                   height = 0.0;
//                 });
//               }
//             },
//             dragUpdate: (details) {
//               print(details.localPosition.dy);
//               print(details.globalPosition.dy);
//               if(panelController.status == SlidingUpPanelStatus.dragging){
//
//               }
//               print(
//                   'dragUpdate,${panelController.status == SlidingUpPanelStatus.dragging ? 'dragging' : ''}');
//             },
//             dragEnd: (details) {
//
//             },
//           ),
//         ),
//         Material(
//           elevation: 3.0,
//           child: SafeArea(
//             child: AnimatedContainer(
//               height: height < 0 ? 0.0 : height/3,
//               color: Colors.white,
//               padding: const EdgeInsets.all(15.0),
//               duration: const Duration(milliseconds: 300),
//               child: Column(
//                 children: [
//                   Row(children: [
//                     InkWell(
//                         onTap: (){
//                           panelController.collapse();
//                           setState(() {
//                             height = 0.0;
//                           });
//                         },
//                         child: const Icon(CupertinoIcons.clear, size: 25.0, color: Colors.black,)),
//                     const SizedBox(width: 20.0,),
//                     const Text('Select destination',style: TextStyle(
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black
//                     ),)
//                   ],),
//                   const SizedBox(
//                     height: 15.0,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Row(
//                       children: [
//                         Column(
//                           children: [
//                             CircleAvatar(radius: 10.0,backgroundColor: Colors.green[700],
//                               child: const CircleAvatar(radius: 3.0,backgroundColor: Colors.white,),),
//                             const SizedBox(
//                               height: 3.0,
//                             ),
//                             Container(
//                               height: 25.0,
//                               width: 3.0,
//                               color: Colors.blueAccent[100],
//                             ),
//                             const SizedBox(
//                               height: 3.0,
//                             ),
//                             CircleAvatar(radius: 10.0,backgroundColor: Colors.blue[700],
//                               child: const CircleAvatar(radius: 3.0,backgroundColor: Colors.white,),),
//                           ],
//                         ),
//                         const SizedBox(
//                           width: 10.0,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               height: 40,
//                               width: MediaQuery.of(context).size.width * 0.7,
//                               child: TextFormField(
//                                 style: const TextStyle(fontSize: 16),
//                                 decoration: kinputTextField.copyWith(
//                                     hintText: 'Select pick-up-location'
//                                 ),
//                                 onChanged: (value){},
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10.0,
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   height: 40,
//                                   width: MediaQuery.of(context).size.width * 0.7,
//                                   child: TextFormField(
//                                     style: TextStyle(fontSize: 16),
//                                     decoration: kinputTextField.copyWith(
//                                       hintText: 'Destination',
//                                     ),
//                                   ),
//                                 ),
//                                 Icon(CupertinoIcons.add,size: 25.0,),
//                               ],
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
