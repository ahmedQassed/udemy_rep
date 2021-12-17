import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/modules/counter_page/cubit/states.dart';

import 'cubit/cubit.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CountrCubit(),
      child: BlocConsumer<CountrCubit, CounterStates>(
          listener: (context, states) {},
          builder: (context, states) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('aaap'),
                ),
                body: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          CountrCubit.get(context).minus();
                        },
                        child: const Text('minus')),
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('${CountrCubit.get(context).counter}')),
                    TextButton(
                        onPressed: () {
                          CountrCubit.get(context).plus();
                        },
                        child: const Text('plus')),
                  ],
                )));
          }),
    );
  }
}
