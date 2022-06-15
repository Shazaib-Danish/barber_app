import 'package:flutter/material.dart';
import 'package:gromify/data%20manager/data_manager.dart';
import 'package:gromify/firebase_data/firebase_data.dart';
import 'package:gromify/model/appointment_model.dart';
import 'package:provider/provider.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard(
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
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
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
                absorbing: isBooked ? true : false,
                child: MaterialButton(
                  color: isBooked ? Colors.grey : Colors.green[800],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  onPressed: () {
                    // showAlertDialog(BuildContext context) {
                    //
                    //   // set up the button
                    //   Widget okButton = TextButton(
                    //     child: const Text("Confirm",style: TextStyle(
                    //       color: Colors.green
                    //     ),),
                    //     onPressed: () { },
                    //   );
                    //
                    //   // set up the AlertDialog
                    //   AlertDialog alert = AlertDialog(
                    //     title: const Text("Confirm Booking"),
                    //     content: Row(
                    //       children: [
                    //         Text('Slot Time'),
                    //       ],
                    //     ),
                    //     actions: [
                    //       okButton,
                    //     ],
                    //   );

                    // show the dialog
                    //   showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return alert;
                    //     },
                    //   );
                    // }

                    final custId =
                        Provider.of<DataManagerProvider>(context, listen: false)
                            .currentUser
                            .customerId;
                    AppointmentModel model = AppointmentModel(
                        customerId: custId,
                        barberId: widget.barberId,
                        startTime: widget.startTime,
                        endTime: widget.endTime,
                        seatNo: seatNo,
                        appointmentStatus: 'Booked',
                        shopName: widget.shopName,
                        shopAddress: widget.shopAddress,
                        barberContact: widget.barberContact);

                    setAppointment(model).whenComplete(() {
                      getAppointmentFromFirebase(widget.barberId, context);
                    });
                  },
                  child: Text(
                    isBooked ? 'Booked' : 'Book Now',
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
