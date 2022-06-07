import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gromify/data%20manager/data_manager.dart';

import 'package:gromify/widgets/barber_tile.dart';
import 'package:provider/provider.dart';
import '../components/k_components.dart';


class AllBarbers extends StatefulWidget {
  const AllBarbers({Key? key}) : super(key: key);

  @override
  State<AllBarbers> createState() => _AllBarbersState();
}

class _AllBarbersState extends State<AllBarbers> {

  TextEditingController searchController = TextEditingController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener(() {
      if (searchController.text.isNotEmpty) {
        Provider.of<DataManagerProvider>(context, listen: false)
            .searchList
            .clear();
        Provider.of<DataManagerProvider>(context, listen: false).setIsSearching(true);
        Provider.of<DataManagerProvider>(context, listen: false)
            .getSearch(searchController.text);
      } else {
        Provider.of<DataManagerProvider>(context, listen: false).setIsSearching(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<DataManagerProvider>(
        builder: (context, data, child){
          return SafeArea(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0),
                itemCount: data.isSearching ? data.getSearchList.length +1  :data.getAllBarbers.length + 1,
                itemBuilder: (context, index) {
                if(index == 0){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_ios)),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('All Barbers', style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 25.0
                        ),),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 60,
                          child: TextFormField(
                            controller: searchController,
                            cursorColor: const Color(0xff8471FF),
                            style: const TextStyle(fontSize: 18.0),
                            decoration: kTextFormFieldDecoration.copyWith(
                              hintText: 'Search...',
                              suffixIcon: const Icon(CupertinoIcons.search)
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                else{
                  return data.isSearching? barberTile(data.getSearchList[index -1], context) :barberTile(data.getAllBarbers[index - 1], context);
                }
                }),
          );
        },
      )
    );
  }
}
