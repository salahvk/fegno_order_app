import 'package:fegno_order_app/data/db/mycart.dart';
import 'package:fegno_order_app/presentation/bloc/bloc/product_bloc.dart';
import 'package:fegno_order_app/presentation/screens/product_ordering_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  registerSingletons();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ProductOrderingPage(),
      ),
    );
  }
}

void registerSingletons() {
  GetIt.I.registerLazySingleton<MyCartList>(() => MyCartList());
}
