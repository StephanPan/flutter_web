class ObjectUtil{
  static bool isEmptyString(String? str){
    return str == null || str.isEmpty;
  }
  static bool isEmptyList(Iterable? list){
    return list == null || list.isEmpty;
  }
}