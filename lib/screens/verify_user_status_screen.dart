import 'package:e_commerce_template/cubit/ads/ads_cubit.dart';
import 'package:e_commerce_template/cubit/categories/categories_cubit.dart';
import 'package:e_commerce_template/cubit/products/products_cubit.dart';
import 'package:e_commerce_template/cubit/toggle_botnavbar/toggle_botnavbar_cubit.dart';
import 'package:e_commerce_template/cubit/user_status/user_status_cubit.dart';
import 'package:e_commerce_template/screens/sign_and_verify_screens/get_started_screen.dart';
import 'package:e_commerce_template/screens/tabs_screen.dart';
import 'package:e_commerce_template/widgets/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyUserStatusScreen extends StatefulWidget {
  static const routeName = '/verify_user_status';

  @override
  _VerifyUserStatusScreenState createState() => _VerifyUserStatusScreenState();
}

class _VerifyUserStatusScreenState extends State<VerifyUserStatusScreen> {
  final auth = FirebaseAuth.instance;

  late final Widget initialScreen;

  @override
  void initState() {
    context.read<UserStatusCubit>().checkUserStatus();
    context.read<ProductsCubit>();
    context.read<CategoriesCubit>();
    context.read<AdsCubit>();
    context.read<ToggleBotNavBarCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserStatusCubit, IsLoggedState>(
      builder: (context, state) {
        print(state);
        if (state is LoggedInState) {
          return TabsScreen();
        } else if (state is NotLoggedInState) {
          return GetStarted();
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text('Trying to check user...'),
                  ),
                  const SizedBox(height: 25.0),
                  LoadingIndicator(height: 36.0),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
