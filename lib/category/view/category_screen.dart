import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_app/category/controller/category_list_bloc.dart';
import 'package:platzi_app/category/controller/category_list_state.dart';
import 'package:platzi_app/core/logger/logger.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CategoryListBloc, CategoryBaseState>(
        builder: (_, state) {
          logger.i("state is $state");
          if (state is CategoryLoadingState) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          logger.i("state is ${state.category.toList()}");
          final category = state.category;
          return ListView.separated(
              itemBuilder: (_, i) {
                Text("id : ${category[i].name}");
                return null;
              },
              separatorBuilder: (_, i) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: category.length);
        },
      ),
    );
  }
}
