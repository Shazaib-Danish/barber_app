import 'package:flutter/material.dart';
import 'package:gromify/data%20manager/data_manager.dart';
import 'package:gromify/widgets/barber_tile.dart';
import 'package:provider/provider.dart';


class SearchingScreen extends StatelessWidget {
  const SearchingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(

      delegate: SliverChildListDelegate(
        [
          Consumer<DataManagerProvider>(
            builder: (context, data, child){
              if(data.searchList.isNotEmpty){
                return Column(
                    children: data.getSearchList.map((x) {
                      return barberTile(x, context);
                    }).toList());
              }
              else{
                return const Align(
                    alignment: Alignment.topCenter,
                    child: Text('Result Not Found'));
              }

            },
          ),
        ]
      )
    );
  }
}
