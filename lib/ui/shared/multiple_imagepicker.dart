import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/photo_porvider.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';

import '../../core/models/app_image.dart';
import 'customAppBar.dart';

class PlugInImageGalleryList extends StatefulWidget {



  @override
  _PlugInImageGalleryListState createState() => _PlugInImageGalleryListState();
}

class _PlugInImageGalleryListState extends State<PlugInImageGalleryList> {

  List<AssetPathEntity>paths=[];
  int pathIndex=0;
  String selectedPath;
  void loadImageList() async {

    List<AssetPathEntity> galleryList = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      hasAll: true,
      onlyAll: true,
      filterOption: FilterOptionGroup(),
    );
    setState(() {
      paths =galleryList;
      selectedPath=paths[0].name;
      print(paths[0].assetCount);
    });
  }
  @override
  void initState() {
    super.initState();
    loadImageList();
  }
  @override
  Widget build(BuildContext context) {

    return BaseView<PhotoProvider>(
      builder: (context,model,child){
        return CustomScaffold(
          appBar: CustomAppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            leading: BackButton(
                  color: Theme.of(context).iconTheme.color,
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            title: DropdownButton<String>(
              dropdownColor:Theme.of(context).cardColor,
              items: paths.map((AssetPathEntity item) {
                return  DropdownMenuItem(
                  child: Text(
                    item.name+' (${item.assetCount})',
                    style: AppStyles.BlackStyleFont_c16(context),
                  ),
                  value: item.name.toString(),
                );
              }).toList(),
              onChanged: (String value) {
                setState(() {
                  selectedPath=value;
                });
                for(int i=0;i<paths.length;i++){
                  if(paths[i].name==value){
                    setState(() {
                      pathIndex=i;
                    });
                  }
                }
              },
              hint: Text('select album',style: AppStyles.BlackStyleFont_c16(context),),
              value: selectedPath,
              style: TextStyle(color: Theme.of(context).focusColor),
            ),
            actions: <Widget>[
              model.selectImages.length>0?IconButton(icon: Icon(Icons.done,color: Theme.of(context).focusColor,), onPressed: (){
                if(Navigator.canPop(context)){
                  Navigator.pop(context,model.selectImages);
                }


              }):Container()
            ],
          ),
          body: paths.length>0?FutureBuilder<List<AssetEntity>>(
            future: paths[0].getAssetListPaged(0, paths[pathIndex].assetCount),
            builder: (BuildContext context, AsyncSnapshot<List<AssetEntity>> snapshot) {

              if (snapshot.hasData) {

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (BuildContext context,int index){
                    return ViewImage(entity: snapshot.data[index],index: index,model: model,);
                  },
                  itemCount: snapshot.data.length,
                );
              }
              return Center(
                child: Text('loading...'),
              );
            },
          ):Container(),
        );
      },
    );
  }

}

class ViewImage extends StatefulWidget {
  final AssetEntity entity;
  final int index;
  final PhotoProvider model;
  ViewImage({this.index,this.entity,this.model});

  @override
  _ViewImageState createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {

  bool isSelected(AppImage appImage,PhotoProvider model){

    if(model.selectedImagePaths.contains(appImage.fileImage.path)){
      return true;
    }else{
      return false;
    }

  }
  File file;
  Uint8List uint8list;
  Future getUinTList()async{
    uint8list= await widget.entity.thumbData;
    setState(() {

    });

  }
  bool loading=true;
  Future getFile()async{


    file=await widget.entity.file;
    setState(() {
      loading=false;
    });

  }
  @override
  void initState() {
    super.initState();
    getUinTList();
    getFile();
  }
  @override
  Widget build(BuildContext context) {

    return uint8list!=null?Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: (){

          bool entry= widget.model.selectedImagePaths.contains(file.path)?false:true;

          if(entry){
            if(widget.model.selectImages.length<5){
              setState(() {
                widget.model.uploadImages(AppImage(uinT8List: uint8list,fileImage: file));
              });
            }else{
              MyUtils().toastdisplay('Maximum 5 can be select');
            }
          }else{
            widget.model.removePickerImage(AppImage(uinT8List: uint8list,fileImage: file));
          }




        },
        child: loading?AppConstants.circulerProgressIndicator():Stack(
          children: <Widget>[
            Image.memory(
              uint8list,

              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,



            ),
            isSelected(AppImage(uinT8List: uint8list,fileImage: file),widget.model)?
            IgnorePointer(
              child: InkWell(
                child: Container(
                  alignment: Alignment.topRight,
                  child:Container(
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height*.01
                      ),
                      child: Icon(Icons.check,color: Colors.white,
                        size:  MediaQuery.of(context).size.height*.02,),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green
                    ),),
                ),
                onTap: ()async{

                },
              ),
            )
                :Container(),
          ],
        ),
      ),
    ): SizedBox(
        height: 40,width: 40,
        child: new CircularProgressIndicator());


  }
}


