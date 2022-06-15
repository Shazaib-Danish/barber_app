import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gromify/data%20manager/data_manager.dart';
import 'package:gromify/firebase_data/firebase_data.dart';
import 'package:gromify/screens/barber/barber_profile.dart';
import 'package:gromify/screens/barber/barber_reviews.dart';
import 'package:gromify/screens/authentications/login%20_screen.dart';
import 'package:gromify/screens/term_condition.dart';
import 'package:gromify/widgets/logout.dart';
import 'package:provider/provider.dart';

class BarberDraawer extends StatelessWidget {
  const BarberDraawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      backgroundColor: Colors.blueGrey,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 10.0),
          child: Column(
            children: [
              Image.asset(
                'assets/logo.png',
                scale: 5.0,
              ),
              const Text(
                'DeveStyle',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              InkWell(
                  onTap: () {
                    // print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaa');
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => BarberProfileScreen()));
                  },
                  child: drawerChild(Icons.account_circle_outlined, 'Profile')),
              InkWell(
                  onTap: () {
                    final myId =
                        Provider.of<DataManagerProvider>(context, listen: false)
                            .currentUser
                            .customerId;
                    getMyAppointmentsFromFirebase(myId, context)
                        .whenComplete(() {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const ReviewsScreen()));
                    });
                  },
                  child: drawerChild(
                      Icons.featured_play_list_outlined, 'Reviews')),
              //drawerChild(Icons.favorite_border_rounded, 'Favorites'),
              //drawerChild(Icons.history, 'History'),
              InkWell(
                  onTap: () {
                    // print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaa');
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => TermsCondtion()));
                  },
                  child:
                      drawerChild(Icons.policy_outlined, 'Terms & Policies')),
              drawerChild(Icons.help_center_outlined, 'Help Center'),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: MaterialButton(
                  onPressed: () {
                    Logout().accountLogout().whenComplete(() {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (Route<dynamic> route) => false);
                    });
                  },
                  color: Colors.grey[700],
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerChild(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30.0,
            color: Colors.white,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
