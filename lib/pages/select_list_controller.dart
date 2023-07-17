
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:juba/models/jobTags.dart';
import 'package:juba/models/offerdetailDTO.dart';

class SelectedListController extends GetxController{
  var _selectedList = List<JobTags>.empty(growable: true).obs;
  getSelectedList() => _selectedList;
  setSelectedList(List<JobTags> list) => _selectedList.value = list;
  addTagsToList(List<JobTags> tags) {
    _selectedList.addAll(tags);
  }

}