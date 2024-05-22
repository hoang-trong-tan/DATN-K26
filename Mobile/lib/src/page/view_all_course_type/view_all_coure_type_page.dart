import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_page.dart';
import '../../utils/app_colors.dart';
import '../detail_course_type.dart/detail_course_type_page.dart';
import 'view_All_coure_type_vm.dart';

class ViewAllCourseTypePage extends StatefulWidget {
  const ViewAllCourseTypePage({super.key});

  @override
  State<ViewAllCourseTypePage> createState() => _ViewAllCourseTypePageState();
}

class _ViewAllCourseTypePageState extends State<ViewAllCourseTypePage> with MixinBasePage<ViewAllCourseTypeVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: AppColors.gray99, width: 0.5),
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.black,
                        size: 20,
                      )),
                ),
              ],
            ),
          ),
          title: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4.5),
            child: const Text(
              'Danh mục',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.listTypeModel.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  mainAxisExtent: 120,
                  childAspectRatio: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailCourseTypePage(nameType: provider.listTypeModel[index]),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.grayA2.withOpacity(0.4),
                        ),
                        child: Image.network(provider.listTypeModel[index].typeThumnail ?? ''),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        provider.listTypeModel[index].typeName ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  ViewAllCourseTypeVM create() {
    return ViewAllCourseTypeVM();
  }

  @override
  void initialise(BuildContext context) {}
}
