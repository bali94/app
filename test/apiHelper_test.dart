import 'package:flutter_test/flutter_test.dart';
import 'package:juba/helpers/apiHelper.dart';
import 'package:juba/providers/offerProvider.dart';

void main() {
  testApi();
}
testApi() {
  test('testAddUser', () async {
   await  ApiHelper().getJwtToken();
  //  var res = await  ApiHelper().getChallengeId();
    //var response = await  ApiHelper().getCaptcha(res!);
   await  ApiHelper().getCompanyData({
     "sessionId": "2F8FCCD6-1014-47A4-82DB-08F23FE864F0",
     "challengeId": "ABA08FC4-921C-4401-8734-81578C85031F",
     "challengeType": "captcha"
   }, '-2d3FAhgyg_0ITDD4cu8Kw1EJEapaH9azpkx5q0BoeU=','srLPFe');
    //  var response  = await ApiHelper().fetchJobs();
   // await ApiHelper.getJobOfferDetailsInWorms();
//    response;
   // expect(response, '658');
  });
}

