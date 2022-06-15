import 'package:flutter/material.dart';
import 'package:gromify/data%20manager/data_manager.dart';
import 'package:gromify/widgets/appoint_card.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CustomerAppointmentScreen extends StatefulWidget {
  const CustomerAppointmentScreen(
      {Key? key,
      required this.shopName,
      required this.barberName,
      required this.seats,
      required this.shopAddress,
      required this.startTime,
      required this.endTime,
      required this.barberId,
      required this.baberContact})
      : super(key: key);

  final String shopName;
  final String barberName;
  final String shopAddress;
  final String baberContact;
  final String barberId;
  final String startTime;
  final String endTime;
  final int seats;

  @override
  _CustomerAppointmentScreenState createState() =>
      _CustomerAppointmentScreenState();
}

class _CustomerAppointmentScreenState extends State<CustomerAppointmentScreen> {
  DateTime now = DateTime.now();
  late DateTime startTime;
  late DateTime endTime;
  late Duration step;

  List<String> timeSlots = [];
  late DateTime sTime;
  late DateTime eTime;

  @override
  initState() {
    super.initState();
    initializeDateFormatting();

    sTime = DateFormat.jm().parse(widget.startTime);
    eTime = DateFormat.jm().parse(widget.endTime);

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
    return Scaffold(
      body: SafeArea(
        child: Consumer<DataManagerProvider>(
          builder: (context, provider, child) {
            return ListView.builder(
                itemCount: timeSlots.length ~/ 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(Icons.arrow_back)),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          widget.shopName,
                          style: const TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            widget.shopAddress,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    );
                  } else {
                    return AppointmentCard(
                      seats: widget.seats,
                      shopAddress: widget.shopAddress,
                      barberContact: widget.baberContact,
                      shopName: widget.shopName,
                      barberId: widget.barberId,
                      startTime: timeSlots[index - 1],
                      endTime: timeSlots[index],
                    );
                  }
                });
          },
        ),
      ),
    );
  }
}
