import 'package:flutter/material.dart';


import '../base/base_page.dart';
import '../model/music_model.dart';
import 'home_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

 

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> with MixinBasePage<HomeVM> {


  @override
  Widget build(BuildContext context) {
    return builder(() => Scaffold(
          // appBar: AppBar(
          //   title: Text("widget.title"),
          //   backgroundColor: Colors.white,
          // ),
          body: ListView.builder(
              itemCount: provider.listData.length,
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(provider.listData[index].title ?? "error"),
                );
              }),
        ));
  }

  @override
  HomeVM create() {
    return HomeVM();
  }

  @override
  void initialise(BuildContext context) {}
}
