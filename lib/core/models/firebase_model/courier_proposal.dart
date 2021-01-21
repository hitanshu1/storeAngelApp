
import 'package:cloud_firestore/cloud_firestore.dart';

class CourierProposal{
  String docID;
  String userID;
  bool isNew;
  DateTime createProposalDate;
  String proposalData;
  CourierProposal({this.userID,this.isNew,this.createProposalDate,this.proposalData});
  CourierProposal.fromMap(Map snapshot,String ID):
        docID=ID,
        userID=snapshot['ID_User']??'',
        isNew=snapshot['bit_isnew']??false,
        createProposalDate=snapshot['dat_CreatedProposal'].runtimeType==Timestamp?snapshot['dat_CreatedProposal'].toDate():snapshot['dat_CreatedProposal']!=''?DateTime.parse(snapshot['dat_CreatedProposal']):null,
        proposalData=snapshot['txt_ProposalData'];

  toJson() {
    return {
      "ID_User": userID,
      "bit_isnew":isNew,
      "dat_CreatedProposal":createProposalDate,
      "txt_ProposalData":proposalData

    };
  }
}