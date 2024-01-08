import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/pages/home/bloc/home_blocs.dart';
import 'package:ulearning_app/pages/home/bloc/home_states.dart';

import '../../common/values/app_colors.dart';
import 'widgets/home_page_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: BlocBuilder<HomeBlocs, HomeStates>(
          builder: (context, state) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 25.w),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: homePageText("Hello", color: AppColors.primaryThirdElementText),
                  ),
                  SliverToBoxAdapter(
                    child: homePageText("Reza Aristo", color: AppColors.primaryText, top: 5),
                  ),
                  SliverPadding(padding: EdgeInsets.only(top: 20.h)),
                  SliverToBoxAdapter(
                    child: searchView(),
                  ),
                  SliverToBoxAdapter(
                    child: slidersView(context, state),
                  ),
                  SliverToBoxAdapter(
                    child: menuView(),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 0.w),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 1.6,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        childCount: 4,
                        (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: courseGrid(),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}

