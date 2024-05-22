import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/page/search/search_vm.dart';
import 'package:kltn/src/page/search/widget/result_search_widget.dart';

import '../../utils/app_colors.dart';
import 'widget/recent_search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with MixinBasePage<SearchVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 80,
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
                        border: Border.all(color: AppColors.gray99, width: 0.5)),
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
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Center(
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width - 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.grayE0.withOpacity(0.5),
                    ),
                    child: TextField(
                      controller: provider.controller,
                      autofocus: true,
                      onSubmitted: (value) {},
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.blue_246BFD,
                        ),
                        hintText: 'Tìm kiếm...',
                        border: InputBorder.none,
                        hintStyle: const TextStyle(color: AppColors.gray99),
                        suffixIcon: provider.checkSearch
                            ? GestureDetector(
                                onTap: () {
                                  provider.controller.clear();
                                  setState(() {
                                    provider.checkSearch = false;
                                  });
                                },
                                child: const Icon(
                                  Icons.cancel_outlined,
                                  color: AppColors.blue_246BFD,
                                ),
                              )
                            : const SizedBox(),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            provider.checkSearch = true;
                            if (provider.debounce?.isActive ?? false) {
                              provider.debounce?.cancel();
                            }

                            provider.debounce = Timer(const Duration(milliseconds: 1000), () {
                              provider.setPrefRecentSearch(value);
                              setState(() {
                                if (provider.controller.text.isNotEmpty) {
                                  provider.checkViewSearch = true;
                                  provider.checkloadingsearch = true;
                                  if (provider.index == 1) {
                                    provider.fetchSearchUser(refresh: true);
                                  } else {
                                    provider.fetchSearchByType(refresh: true);
                                  }
                                }
                              });
                            });
                          });
                        } else {
                          setState(() {
                            provider.checkSearch = false;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: provider.checkViewSearch == false
              ? RecentSearchWidget(provider: provider)
              : ResultSearchWidget(provider: provider),
        ),
      ),
    );
  }

  @override
  SearchVM create() {
    return SearchVM();
  }

  @override
  void initialise(BuildContext context) {}
}
