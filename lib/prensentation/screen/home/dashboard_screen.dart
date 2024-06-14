import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_app/category/view/category_screen.dart';
import 'package:platzi_app/prensentation/screen/home/controller/dashboard_bloc.dart';
import 'package:platzi_app/prensentation/screen/home/controller/dashboard_event.dart';
import 'package:platzi_app/prensentation/screen/home/controller/dashboard_state.dart';
import 'package:platzi_app/prensentation/screen/home/widget/setting_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DashboardNavigationBloc>();
    return Scaffold(
      bottomNavigationBar:
          BlocBuilder<DashboardNavigationBloc, DashboardNavigationState>(
              builder: (_, state) {
        return BottomNavigationBar(
          currentIndex: state.i,
          onTap: (value) {
            bloc.add(DashboardNavigationEvent(value));
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Category"),
            BottomNavigationBarItem(
                icon: Icon(Icons.production_quantity_limits), label: "Product"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Setting"),
          ],
        );
      }),
      body: BlocBuilder<DashboardNavigationBloc, DashboardNavigationState>(
          builder: (_, state) {
        return [
          const CategoryScreen(),
          const CategoryScreen(),
          const SettingScreen(),
        ][state.i];
      }),
    );
  }
}
