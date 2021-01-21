import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_addnewuser.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/widgets/items/item_appbar.dart';
import 'package:storeangelApp/ui/widgets/share/view_user.dart';

class AddNewUserScreen extends StatefulWidget {
  static const String routeName = 'addNewUser';

  @override
  _AddNewUserScreenState createState() => _AddNewUserScreenState();
}

class _AddNewUserScreenState extends State<AddNewUserScreen> {
  TextEditingController _searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
    return BaseView<AddNewUserViewModel>(
      onModelReady: (addNewUserViewModel) => addNewUserViewModel.initialize(_scrollController),
      builder: (context, addNewUserViewModel, child) {
        if (addNewUserViewModel.state == ViewState.Busy) {
          return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: AppConstants.circulerProgressIndicator());
        } else {
          return Scaffold(
            appBar: ItemAppbar(
              elevation: addNewUserViewModel.hasShadow ? 4 : 0,
              title: AppStrings.USER_NAME.tr(),
              controller: _searchController,
              onSubmit: (val) {
                addNewUserViewModel.getSearchUserList(_searchController.text);
              },
              onClear: () {
                _searchController.clear();
                addNewUserViewModel.clearUserList();
              },
            ),
            body: addNewUserViewModel.userList.length == 0
                ? Container(
                    child: Center(
                      child: Padding(
                        padding: SizeConfig.largePadding,
                        child: Text(
                          AppStrings.FIND_A_USER_YOU_WANT_TO_SHARE_THE_LIST_WITH.tr(),
                          style: AppStyles.BlackStyleWithBold600Font_24(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: addNewUserViewModel.userList.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: SizeConfig.verticalBigPadding,
                        child: ViewUser(
                          user: addNewUserViewModel.userList[index],
                          fromPage: ViewUserFromPage.AddUser,
                          onTap: () {
                            addNewUserViewModel.shareUser(addNewUserViewModel.userList[index]);
                          },
                        ),
                      );
                    }),
          );
        }
      },
    );
  }
}
