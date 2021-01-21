
import 'dart:convert';

import 'package:storeangelApp/core/models/stripe_verify_account.dart';
import 'package:storeangelApp/core/services/base_api.dart';

class StripVerificationService extends BaseApi{

  Future createAccount()async{
    try{
      return postRequest('/v1/accounts', (r) {
        return json.decode(r.body)['id'];
      },{
        'type':'standard'
      });
    }catch(e){
      print(e.toString());
      return null;
    }

  }

  Future getAccountLink(String accountId)async{
    try{
      return postRequest('/v1/account_links', (r) {
        return json.decode(r.body)['url'];
      },{
        'account':accountId,
        'refresh_url':'https://example.com/reauth',
        'return_url':'https://example.com/return',
        'type':'account_onboarding'
      });
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Future getAccountDetails(String accountId){
    return getRequest('/v1/accounts/$accountId', (r) =>StripeVerifyAccount.fromJson(json.decode(r.body)));
  }


}