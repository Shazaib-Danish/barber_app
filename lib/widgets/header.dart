import 'package:flutter/material.dart';
import 'package:gromify/data%20manager/data_manager.dart';
import 'package:gromify/theme/extention.dart';
import 'package:provider/provider.dart';

import '../theme/text_styles.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Hello,",
          style: TextStyles.title,
        ),
        Text(
            Provider.of<DataManagerProvider>(context)
                .currentUser
                .customerFullName,
            style: TextStyles.h1Style),
      ],
    ).p16;
  }
}
