import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_listuser.dart';
import 'package:storeangelApp/ui/screens/addnew_user_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/widgets/share/floating_action_animation.dart';
import 'package:storeangelApp/ui/widgets/share/view_user.dart';

class ListUsersScreen extends StatefulWidget {
  static const String routeName = 'ListUsers';

  @override
  _ListUsersScreenState createState() => _ListUsersScreenState();
}

class _ListUsersScreenState extends State<ListUsersScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
    return BaseView<ListUserViewModel>(
      onModelReady: (listUserViewModel) => listUserViewModel.initialize(_scrollController),
      builder: (context, listUserViewModel, child) {
        if (listUserViewModel.state == ViewState.Busy) {
          return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: AppConstants.circulerProgressIndicator());
        } else {
          return Scaffold(
            appBar: CustomAppBar(
              elevation: listUserViewModel.hasShadow?4.0:0,
              leading: BackButton(
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                AppStrings.LIST_USERS.tr(),
                style: AppStyles.BlackStyleWithBold800Font_24(context),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
            ),
            body: ListView.builder(
              controller: _scrollController,
                itemCount: listUserViewModel.users.length+1,
                itemBuilder: (context, int index) {
                if(index==listUserViewModel.users.length)return SizeConfig.verticalSpaceLargeBig();
                  return Padding(
                    padding: SizeConfig.verticalBigPadding,
                    child: InkWell(
                      child: Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.4,
                          secondaryActions: listUserViewModel.users[index].name != listUserViewModel.username
                              ? <Widget>[
                                  IconSlideAction(
                                    foregroundColor: AppColors.primaryColor,
                                    color: Colors.red,
                                    iconWidget: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            StoreangelIcons.delete_icon,
                                            color: Theme.of(context).focusColor,
                                            size: SizeConfig.iconSize,
                                          ),
                                          onPressed: () {},
                                        ),
                                        SizeConfig.horizontalSpaceSmall(),
                                        Text(
                                          AppStrings.DELETE.tr(),
                                          style: AppStyles.WhiteStyle_Font16,
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      listUserViewModel.removeUser(listUserViewModel.users[index]);
                                    },
                                  ),
                                ]
                              : [],
                          child: ViewUser(
                            user: listUserViewModel.users[index],
                            fromPage: ViewUserFromPage.ListUser,
                          )),
                      onTap: () {},
                    ),
                  );
                }),
            floatingActionButtonAnimator: NoScalingAnimation(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * .1,
                  right: SizeConfig.screenWidth * .1,
                  bottom: SizeConfig.screenHeight * .04),
              child: ButtonWidget(
                  radius: AppConstants.button_Radius,
                  fontSize: AppConstants.fontSizeSmall,
                  buttonColor: AppColors.green,
                  buttonText: AppStrings.ADD_NEW.tr(),
                  onPressed: () {
                    listUserViewModel.navigateToScreen(AddNewUserScreen.routeName);
                  }),
            ),
          );
        }
      },
    );
  }
}
