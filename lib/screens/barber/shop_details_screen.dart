import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gromify/components/k_components.dart';
import 'package:gromify/data%20manager/data_manager.dart';
import 'package:gromify/firebase_data/firebase_data.dart';
import 'package:map_location_picker/google_map_location_picker.dart';
import 'package:provider/provider.dart';

import '../../widgets/pic_up_location.dart';
import 'barber_dashboard.dart';

class ShopDetailsScreen extends StatefulWidget {
  ShopDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  TimeOfDay initialTime = TimeOfDay.now();

  TextEditingController shopNameController = TextEditingController();
  TextEditingController seatsController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late TimeOfDay startingTime;
  late TimeOfDay endingTime;
  bool startingTimeSelected = false;
  bool endingTimeSelected = false;
  bool selectedLocation = false;
  bool isLoading = false;

  late LocationResult result = LocationResult();

  Future<void> _startingTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );


    setState(() {
      startingTime = pickedTime!;

      startingTimeSelected = true;
    });
  }

  Future<void> _endingTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    endingTimeSelected = true;
    setState(() {
      endingTime = pickedTime!;
    });
  }

  void getPicked() {
    showLocationPicker(context, "AIzaSyDnLt_w5gSghxwwTJybvgFIwq8CrOFn_U4",
        initialCenter: const LatLng(31.1975844, 29.9598339),
        myLocationButtonEnabled: true,
        layersButtonEnabled: true,
        countries: ['Pk']).then((value) {
      setState(() {
        result = value!;
        selectedLocation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(15.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter your shop Details',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      controller: shopNameController,
                      decoration: kTextFormFieldDecoration.copyWith(
                        hintText: 'Shop Name',
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Text is empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Text is empty';
                        }
                        return null;
                      },
                      controller: seatsController,
                      decoration: kTextFormFieldDecoration.copyWith(
                          hintText: 'Enter No. of Seats'),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: 5,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Text is empty';
                        }
                        return null;
                      },
                      decoration: kTextFormFieldDecoration.copyWith(
                        hintText: 'Description',
                      ),
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    const Text(
                      'Timings',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('From'),
                            const SizedBox(
                              height: 5.0,
                            ),
                            InkWell(
                              onTap: () {
                                _startingTime(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color(0xffb8b5cb),
                                    ),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Row(
                                  children: [
                                    Text(
                                      startingTimeSelected
                                          ? startingTime.format(context)
                                          : 'Select Time',
                                      style: const TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    const Icon(Icons.access_time),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('To'),
                            const SizedBox(
                              height: 5.0,
                            ),
                            InkWell(
                              onTap: () {
                                _endingTime(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color(0xffb8b5cb),
                                    ),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Row(
                                  children: [
                                    Text(
                                      endingTimeSelected
                                          ? endingTime.format(context)
                                          : 'Select Time',
                                      style: const TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    const Icon(Icons.access_time),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    InkWell(
                      onTap: () {
                        getPicked();
                        setState(() {
                          selectedLocation = false;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Choose your shop location',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          Icon(Icons.arrow_forward_sharp)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    InkWell(
                      onTap: () {
                        getPicked();
                        setState(() {
                          selectedLocation = false;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1.0,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: selectedLocation
                            ? InkWell(
                                onTap: () {
                                  getPicked();
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: PickedUpLocation(
                                      latitude: result.latLng.latitude,
                                      longitude: result.latLng.longitude),
                                ),
                              )
                            : const Center(
                                child: Text('Tap and Pick'),
                              ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: const Color(0xffb8b5cb))),
                      ),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      result.address,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (result.address.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Select everything carefully'),
                            ));
                          } else {
                            Provider.of<DataManagerProvider>(context,
                                    listen: false)
                                .setBarberShopInfo(
                                    shopNameController.text,
                                    seatsController.text,
                                    descriptionController.text,
                                    result.address,
                                    result.latLng.latitude,
                                    result.latLng.longitude,
                                    startingTime.format(context),
                                    endingTime.format(context));
                            addBarberProfileData(context).whenComplete(() {
                              Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          BarberDashboard()));
                            });
                          }
                        }
                      },
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: const Color(0xff8471FF),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Next',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20.0,
                                    color: Colors.white),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
