import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multisol/src/feature/foot_add/pages/foot_add_page.dart';
import 'package:multisol/src/feature/foot_list/pages/foot_list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/my/pages/my_page.dart';
import 'utils/custom_color.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
  }

  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  Widget _tabBar() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(),
        splashFactory: NoSplash.splashFactory,
        dividerColor: Colors.transparent,
        tabs: [
          Tab(
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/home.svg',
                  height: 25,
                  color: _tabController.index == 0
                      ? CustomColors.mainBlack
                      : CustomColors.mainGrey.withOpacity(0.3),
                  colorBlendMode: BlendMode.modulate,
                ),
                Text(
                  '목록',
                  style: TextStyle(
                    fontSize: 12,
                    color: _tabController.index == 0
                        ? CustomColors.mainBlack
                        : CustomColors.mainGrey,
                  ),
                ),
              ],
            ),
          ),
          Tab(
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/add.svg',
                  height: 25,
                  color: _tabController.index == 1
                      ? CustomColors.mainBlack
                      : CustomColors.mainGrey.withOpacity(0.3),
                  colorBlendMode: BlendMode.modulate,
                ),
                Text(
                  '인솔 등록하기',
                  style: TextStyle(
                    fontSize: 12,
                    color: _tabController.index == 1
                        ? CustomColors.mainBlack
                        : CustomColors.mainGrey,
                  ),
                ),
              ],
            ),
          ),
          Tab(
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/my.svg',
                  height: 25,
                  color: _tabController.index == 2
                      ? CustomColors.mainBlack
                      : CustomColors.mainGrey.withOpacity(0.3),
                  colorBlendMode: BlendMode.modulate,
                ),
                Text(
                  '마이페이지',
                  style: TextStyle(
                    fontSize: 12,
                    color: _tabController.index == 2
                        ? CustomColors.mainBlack
                        : CustomColors.mainGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
        onTap: (index) {
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              viewportFraction: 1,
              children: const [
                FootListPage(),
                FootAddPage(),
                MyPage(),
              ],
            ),
          ),
          _tabBar(),
        ],
      ),
    );
  }
}
