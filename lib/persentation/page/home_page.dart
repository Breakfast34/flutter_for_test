// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer' as dev;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/persentation/state.dart/bloc/data_bloc_bloc.dart';
import 'package:flutter_application_1/persentation/widget/carouse_loading_page.dart';
import 'package:flutter_application_1/persentation/widget/dialog.dart';
import 'package:flutter_application_1/persentation/widget/glass_morphic.dart';
import 'package:flutter_application_1/persentation/widget/gridview_loading_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_package_2/data_flutter_for_test.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataBloc _dataUserBlocBloc = DataBloc();
  @override
  void initState() {
    super.initState();
    _dataUserBlocBloc.add(const DepartmentEvent());
  }

  List<Department> department = [];
  List<Product> listProducts = [];
  String departmentName = "";
  int? i;
  CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Department carousel',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BlocListener<DataBloc, DataBlocState>(
            bloc: _dataUserBlocBloc,
            listener: (context, state) {
              if (state is ProductBlocError) {
                dev.log('Error: ${state.message}');
              } else if (state is DepartmentBlocLoaded) {
                department = state.response!.departments;
                // departmentName = state.department!;
              } else if (state is DataBlocLoading) {
                dev.log('DataUserBlocLoading 1');
              } else if (state is ProductBlocLoaded) {
                listProducts = state.response!.products;
              }
            },
            child: FutureBuilder(
              future: Future.delayed(
                const Duration(seconds: 2),
                () {
                  _dataUserBlocBloc.add(const DepartmentEvent());
                },
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CarouselLoading(
                    carouselController: carouselController,
                    itemCount: department.length,
                    options: CarouselOptions(
                      height: 130,
                      viewportFraction: 0.4,
                      padEnds: false,
                    ),
                  );
                }
                return CarouselLoading(
                  carouselController: carouselController,
                  itemCount: department != [] && department.isNotEmpty
                      ? department.length
                      : 0,
                  options: CarouselOptions(
                    autoPlayInterval: const Duration(seconds: 3),
                    height: 150,
                    autoPlay: true,
                    viewportFraction: 0.4,
                    onPageChanged: (index, reason) {
                      i = index - 1;
                      if (index == 0) {
                        i = 0;
                        _dataUserBlocBloc
                            .add(ProductEvent(click: department[i!].id));
                      } else {
                        _dataUserBlocBloc
                            .add(ProductEvent(click: department[i!].id));
                      }
                      Padding(
                        padding: const EdgeInsets.only(right: 15, top: 15),
                        child: Text(departmentName,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.background,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            )),
                      );
                    },
                  ),
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    i = index;
                    departmentName = department[i!].name;

                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        GlassBox(
                          widget: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(20), // Image border
                            child: SizedBox.fromSize(
                              child: Image.network(
                                department[index].imageUrl,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                scale: 1.0,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15, top: 15),
                          child: Text(department[i!].name,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.background,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              )),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: BlocBuilder<DataBloc, DataBlocState>(
              bloc: _dataUserBlocBloc,
              builder: (context, state) {
                if (state is ProductBlocLoaded) {
                  return Text(
                    'Product listing ${department[i!].name}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return Text(
                  'Product listing',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          BlocConsumer<DataBloc, DataBlocState>(
            bloc: _dataUserBlocBloc,
            listener: (context, state) {
              if (state is ProductBlocError) {
                dev.log('Error: ${state.message}');
              } else if (state is ProductBlocLoaded) {
                listProducts = state.response!.products;
              } else if (state is DataBlocLoading) {
                dev.log('DataUserBlocLoading 2');
              }
            },
            builder: (context, state) {
              if (state is ProductBlocError) {
                dev.log('Error: ${state.message}');
                return const CircularProgressIndicator();
              } else if (state is ProductBlocLoaded) {
                return Expanded(
                  flex: 1,
                  child: GridviewLoading(
                    itemCount: listProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return ShowDialog(
                                  productDesc: listProducts[index].name,
                                  description: listProducts[index].desc,
                                );
                              });
                        },
                        child: detail(context, index),
                      );
                    },
                  ),
                );
              } else if (state is DataBlocLoading) {
                dev.log('DataUserBlocLoading');
                return Expanded(
                  child: GridviewLoading(
                    itemCount: 10,
                  ),
                );
              }
              return Expanded(
                child: GridviewLoading(
                  itemCount: 10,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Container detail(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(4, 5),
          ),
        ],
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20), // Image border
            child: SizedBox.fromSize(
              child: Image.network(
                listProducts[index].imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                scale: 1.0,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 90,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(26),
                  bottomRight: Radius.circular(26),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listProducts[index].name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    listProducts[index].desc,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Theme.of(context).colorScheme.background,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      listProducts[index].price,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Theme.of(context).colorScheme.background,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
