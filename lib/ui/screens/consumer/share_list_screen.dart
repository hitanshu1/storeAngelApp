import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_share_list.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/widgets/share_list/share_list_header.dart';
import 'package:storeangelApp/ui/widgets/share_list/share_selected_user_list_widget.dart';
import 'package:storeangelApp/ui/widgets/share_list/share_user_list_widget.dart';
class ShareListScreen extends StatelessWidget {
  static const String routeName='shareListScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BaseView<ShareListViewModel>(
        builder: (context,model,child){
          if(model.state==ViewState.Busy){
            return AppConstants.circulerProgressIndicator();
          }
          return  CustomScrollView(
            slivers: [
              ShareListHeader(),
              model.searchText?ShareUserListWidget():ShareSelectedUserListWidget()
            ],
          );
        },
      ),
    );
  }
}
