import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gromify/screens/dashboard.dart';

class TermsCondtion extends StatelessWidget {
  const TermsCondtion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Term & Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              heading('END USER LICENSE AGREEMENT '),
              const SizedBox(
                height: 5.0,
              ),
              heading('Last updated June 12, 2022 \n Developed by: FYP-001 '),
              const SizedBox(
                height: 5.0,
              ),
              para(
                  'DeveStyle is licensed to You (End-User) by Silver Soft, located and registered at Gulberg III, Lahore, Punjab, Lahore, Punjab 5400, Pakistan ("Licensor"), for use only under the terms of this License Agreement.  By downloading the Licensed Application from Apple\'s software distribution platform ("App Store"), and any update thereto (as permitted by this License Agreement), You indicate that You agree to be bound by all of the terms and conditions of this License Agreement, and that You accept this License Agreement. App Store is referred to in this License Agreement as "Services."  The parties of this License Agreement acknowledge that the Services are not a Party to this License Agreement and are not bound by any provisions or obligations with regard to the Licensed Application, such as warranty, liability, maintenance and support thereof. Silver Soft, not the Services, is solely responsible for the Licensed Application and the content thereof.  '),
              const SizedBox(
                height: 5.0,
              ),
              heading('THE APPLICATION '),
              const SizedBox(
                height: 5.0,
              ),
              para(
                  'DeveStyle ("Licensed Application") is a piece of software created to Book an barber for haircut — and customized for iOS mobile devices ("Devices"). It is used to appointment. '),
              const SizedBox(
                height: 5.0,
              ),
              heading('LEGAL COMPLIANCE '),
              const SizedBox(
                height: 5.0,
              ),
              para(
                  'You represent and warrant that You are not located in a country that is subject to a US Government embargo, or that has been designated by the US Government as a "terrorist supporting" country; and that You are not listed on any US Government list of prohibited or restricted parties'),
              const SizedBox(
                height: 5.0,
              ),
              heading(' CONTACT INFORMATION'),
              const SizedBox(
                height: 5.0,
              ),
              para(
                  'For general inquiries, complaints, questions or claims concerning the Licensed Application, please contact: Developed by: FYP-001'
                  'Gulberg III, Lahore, Punjab Lahore, Punjab 5400 Pakistan '),
              const SizedBox(
                height: 5.0,
              ),
              heading('INTELLECTUAL PROPERTY RIGHTS '),
              const SizedBox(
                height: 5.0,
              ),
              para(
                  'Silver Soft and the End-User acknowledge that, in the event of any third-party claim that the Licensed Application or the End-User\'s possession and use of that Licensed Application infringes on the third party\'s intellectual property rights, Silver Soft, and not the Services, will be solely responsible for the investigation, defense, settlement, and discharge or any such intellectual property infringement claims. '),
              MaterialButton(
                  color: Colors.green,
                  child: Text('Agree'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => HomePageScreen()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

Widget heading(String head) {
  return Text(
    head,
    style: const TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 16.0,
    ),
  );
}

Widget para(String para) {
  return Text(
    para,
    style: const TextStyle(
      fontSize: 12.0,
    ),
  );
}
