import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gromify/theme/extention.dart';

import '../../model/barber_model.dart';
import '../../screens/all_barbers.dart';
import '../../theme/text_styles.dart';
import '../barber_tile.dart';

Widget barbersList(List<BarberModel> barber, BuildContext context) {
  return SliverList(
    delegate: SliverChildListDelegate(
      [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("All Barbers", style: TextStyles.title.bold),
            IconButton(
                icon: Icon(
                  Icons.sort,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const AllBarbers()));
                })
            // .p(12).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
          ],
        ).hP16,
        getbarberWidgetList(barber, context)
      ],
    ),
  );
}

Widget getbarberWidgetList(
    List<BarberModel> barberDataList, BuildContext context) {
  return Column(
      children: barberDataList.map((x) {
    return barberTile(x, context);
  }).toList());
}
