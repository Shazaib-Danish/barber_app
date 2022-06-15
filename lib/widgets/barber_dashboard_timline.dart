import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gromify/data%20manager/data_manager.dart';
import 'package:gromify/firebase_data/firebase_data.dart';
import 'package:gromify/model/appointment_model.dart';
import 'package:provider/provider.dart';

class BarberTimeLine extends StatefulWidget {
  const BarberTimeLine(
      {Key? key,
        required this.seats,
        required this.startTime,
        required this.endTime,
        required this.barberId,
        required this.shopName,
        required this.shopAddress,
        required this.barberContact})
      : super(key: key);

  final int seats;
  final String barberId;
  final String startTime;
  final String shopName;
  final String shopAddress;
  final String barberContact;
  final String endTime;

  @override
  State<BarberTimeLine> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<BarberTimeLine> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
      child: Consumer<DataManagerProvider>(
        builder: (context, provider, child) {
          return Consumer<DataManagerProvider>(
            builder: (context, provider, child) {
              return Material(
                borderRadius: BorderRadius.circular(15.0),
                elevation: 8.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListView.builder(
                      itemCount: widget.seats,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        bool booked = false;

                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Slot > ${widget.startTime} - ${widget.endTime}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          );
                        } else {
                          bool booked = false;
                          for (var data in provider.appointmentList) {
                            if (data.startTime == widget.startTime &&
                                data.seatNo == index &&
                                data.appointmentStatus == 'Booked') {
                              booked = true;
                            }
                          }
                          return singleApp(index, context, booked);
                        }
                      }),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget singleApp(int seatNo, BuildContext context, bool isBooked) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$seatNo',
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              Icon(
                Icons.event_seat_rounded,
                size: 45.0,
                color: isBooked ? Colors.grey : Colors.green,
              ),
              AbsorbPointer(
                absorbing: isBooked ? false : true,
                child: MaterialButton(
                  color: isBooked ? Colors.red : Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  onPressed: () async{
                    if(isBooked){
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
                      await docRef.delete();
                    }
                  },
                  child: Text(
                    isBooked ? 'Cancel' : 'Waiting',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
