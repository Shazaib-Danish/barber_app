import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:gromify/data%20manager/data_manager.dart';
import 'package:gromify/firebase_data/firebase_data.dart';
import 'package:gromify/widgets/barber_dashboard_timline.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../widgets/barber_draawer.dart';

class BarberDashboard extends StatefulWidget {
  BarberDashboard({Key? key}) : super(key: key);

  @override
  State<BarberDashboard> createState() => _BarberDashboardState();
}

class _BarberDashboardState extends State<BarberDashboard> {
  final _advancedDrawerController1 = AdvancedDrawerController();

  DateTime now = DateTime.now();
  late DateTime startTime;
  late DateTime endTime;
  late Duration step;

  List<String> timeSlots = [];
  late DateTime sTime;
  late DateTime eTime;

  bool isOpen = false;

  @override
  initState() {
    getTIme();
    super.initState();
  }

  Future<void> getTIme()async{
    initializeDateFormatting();

    // final stTime =  Provider.of<DataManagerProvider>(context, listen: false)
    //     .getBarberProfile
    //     .shopStatus
    //     .startTime;
    // final etTime = Provider.of<DataManagerProvider>(context, listen: false)
    //     .getBarberProfile
    //     .shopStatus
    //     .endTime;

    String esTime = '10:00 AM';
    String etTime = '9:00 AM';

    sTime = DateFormat.jm().parse(esTime);
    eTime = DateFormat.jm().parse(etTime);

    startTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(DateFormat("HH").format(sTime)),
        int.parse(DateFormat("mm").format(sTime)),
        0);
    endTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(DateFormat("HH").format(eTime)),
        int.parse(DateFormat("mm").format(eTime)),
        0);
    step = Duration(minutes: 30);

    while (startTime.isBefore(endTime)) {
      DateTime timeIncrement = startTime.add(step);
      timeSlots.add(DateFormat.Hm().format(timeIncrement));
      startTime = timeIncrement;
    }
    print(timeSlots);
  }

  @override
  Widget build(BuildContext context) {

    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController1,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 400),
      animateChildDecoration: true,
      rtlOpening: false,
      //openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: const BarberDraawer(),
      child: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('Appointments').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          getAppointmentFromFirebase(
              Provider.of<DataManagerProvider>(context)
                  .getBarberProfile
                  .barber
                  .barberId,
              context);
          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  _advancedDrawerController1.showDrawer();
                },
                child: const Icon(
                  Icons.short_text,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.white,
              title: const Text(
                'Dashboard',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedToggleSwitch<bool>.dual(
                    current: isOpen,
                    first: false,
                    second: true,
                    dif: 50.0,
                    borderColor: Colors.transparent,
                    borderWidth: 5.0,
                    height: 55,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1.5),
                      ),
                    ],
                    onChanged: (b) => setState(() async{
                      setState(() {
                        isOpen = b;
                      });
                      if (isOpen) {
                        QuerySnapshot querySnap = await FirebaseFirestore
                            .instance
                            .collection('Barbers')
                            .where('barberId',
                                isEqualTo:
                                    Provider.of<DataManagerProvider>(context, listen: false)
                                        .getBarberProfile
                                        .barber
                                        .barberId)
                            .get();
                        QueryDocumentSnapshot doc = querySnap.docs[
                            0]; // Assumption: the query returns only one document, THE doc you are looking for.
                        DocumentReference docRef = doc.reference;
                        await docRef.update({
                          'shopStatus' : 'Open'
                        });
                      }
                      else{
                        QuerySnapshot querySnap = await FirebaseFirestore
                            .instance
                            .collection('Barbers')
                            .where('barberId',
                            isEqualTo:
                            Provider.of<DataManagerProvider>(context)
                                .getBarberProfile
                                .barber
                                .barberId)
                            .get();
                        QueryDocumentSnapshot doc = querySnap.docs[
                        0]; // Assumption: the query returns only one document, THE doc you are looking for.
                        DocumentReference docRef = doc.reference;
                        await docRef.update({
                          'shopStatus' : 'Close'
                        });
                      }
                    }),
                    colorBuilder: (b) => b ? Colors.red : Colors.green,
                    iconBuilder: (value) => value
                        ? Icon(Icons.arrow_back_ios)
                        : Icon(Icons.arrow_forward_ios_sharp),
                    textBuilder: (value) => value
                        ? Center(child: Text('Oh no...'))
                        : Center(child: Text('Nice :)')),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Consumer<DataManagerProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                      itemCount: timeSlots.length ~/ 2,
                      itemBuilder: (context, index) {
                        return BarberTimeLine(
                          seats: int.parse(provider.getBarberProfile.seats),
                          shopAddress:
                              provider.getBarberProfile.location.address,
                          barberContact:
                              provider.getBarberProfile.barber.barberContact,
                          shopName: provider.getBarberProfile.shopName,
                          barberId: provider.getBarberProfile.barber.barberId,
                          startTime: timeSlots[index],
                          endTime: timeSlots[index + 1],
                        );
                      });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
