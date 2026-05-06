import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrilens/core/constants/app_constants.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/router/routes.dart';
import 'package:nutrilens/core/utils/custom_snack_bar.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/profile/logic/cubit.dart';
import 'package:nutrilens/core/theme/cubit/cubit.dart';

part 'shared_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<ProfileCubit>()..getUserProfile(),
      child: BlocListener<ProfileCubit, ProfileState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == ProfileStatus.success && state.user == null) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
              (route) => false,
            );
          }
          if (state.status == ProfileStatus.failure) {
            customSnackBar(
              context: context,
              message: (state.error?.isNotEmpty ?? false)
                  ? state.error!
                  : "حدث خطأ ما، حاول مرة أخرى",
              isErrorMessage: true,
            );
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const _ProfileAppBar(),
          body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state.status == ProfileStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorsManager.primary,
                  ),
                );
              }

              if (state.status == ProfileStatus.failure) {
                return const ProfileErrorWidget();
              }

              return RefreshIndicator(
                onRefresh: () => context.read<ProfileCubit>().getUserProfile(),
                color: ColorsManager.primary,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: Column(
                    children: [
                      ProfileHeaderCard(user: state.user),
                      heightSpace(24),
                      const _PreferencesHeader(),
                      heightSpace(16),
                      const ProfileSettingsList(),
                      heightSpace(32),
                      const LogoutButton(),
                      heightSpace(30),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
