import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/share_status.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

enum ViewUserFromPage { ListUser, AddUser }

class ViewUser extends StatefulWidget {
  final UserModel user;
  final ViewUserFromPage fromPage;
  final Function onTap;

  ViewUser({this.user, @required this.fromPage, this.onTap});

  @override
  _ViewUserState createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  String username = 'Jessica miles';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: SizeConfig.paddingHeighy02,
        child: Row(
          children: [
            ViewAppImage(
              imageUrl: widget.user.imageUrl,
              height: SizeConfig.smallImageHeight55,
              width: SizeConfig.smallImageHeight55,
              radius: SizeConfig.smallImageHeight55,
            ),
            SizeConfig.horizontalSpaceSmall(),
            Expanded(
              child: Text(
                widget.user.name != username ? widget.user.name : AppStrings.YOU.tr(),
                style: AppStyles.BlackStyleWithBold800Font_20(context),
              ),
            ),
            widget.fromPage == ViewUserFromPage.ListUser
                ? Container(
                    child: widget.user.status == ShareStatus.Approve
                        ? DecoratedBox(
                            decoration: BoxDecoration(color: AppColors.whiteColor, shape: BoxShape.circle),
                            child: Image.asset(AssetsPath.check_checkbox),
                          )
                        : Text(
                            AppStrings.PENDING.tr(),
                            style: AppStyles.GreenStyleWithBold600_Font16(context),
                          ),
                  )
                : InkWell(
                    child: Container(
                      height: 40,
                      width: 80,
                      child: Center(
                        child: widget.user.status == ShareStatus.Unknown
                            ? Text(
                                AppStrings.SHARE.tr(),
                                style: AppStyles.GreenStyleWithBold600_Font16(context),
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10, child: Image.asset(AssetsPath.cirlerTickGray)),
                                  SizeConfig.horizontalSpace(5),
                                  Text(
                                    AppStrings.SHARED.tr(),
                                    style: AppStyles.WhiteStyleWithBold600_Font16,
                                  ),
                                ],
                              ),
                      ),
                      decoration: BoxDecoration(
                          color: widget.user.status == ShareStatus.Unknown ? Colors.transparent : AppColors.green,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.green)),
                    ),
                    onTap: () {
                      if (widget.user.status == ShareStatus.Unknown) {
                        setState(() {
                          widget.user.status = ShareStatus.Shared;
                        });
                      }
                      widget.onTap();
                    },
                  )
          ],
        ),
      ),
      color: Theme.of(context).cardColor,
    );
  }
}
