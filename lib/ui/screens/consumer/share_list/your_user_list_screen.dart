import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/user.dart';

import 'package:storeangelApp/ui/shared/premium_widget.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:storeangelApp/ui/widgets/your_user_list/your_user_list_header.dart';
import 'package:storeangelApp/ui/widgets/your_user_list/your_user_list_view_user_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class YourUserListScreen extends StatelessWidget {
  static const String routeName='yourUserLIstScreen';
  final UserModel selectedUser;
  YourUserListScreen({this.selectedUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          YourUserListHeader(),
          SizeConfig.verticalSliverMediumSpace(),
          SliverToBoxAdapter(
            child: Padding(
              padding: SizeConfig.sidepadding,
              child: TitleTextWidget(
                title: AppStrings.ATTACHED_TO.tr(),
              ),
            ),
          ),
          SizeConfig.verticalSliverMediumSpace(),
          SliverPadding(
            padding: SizeConfig.sidepadding,
            sliver: YourUserListViewUserWidget(user: selectedUser,),
          ),
          SizeConfig.verticalSliverMediumSpace(),
          SliverToBoxAdapter(
            child: PremiumWidget(),
          ),
        ],
      ),
    );
  }
}
