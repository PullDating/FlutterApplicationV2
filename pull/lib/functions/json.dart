
Map<String,Object> filterTypeConversion(Map<String, Object?> json){
  Map<String,Object> newJson = <String,Object>{};
  json.forEach((key, value) {
    print("key: $key, value: $value");
    print("typeof value: " + value.runtimeType.toString());

    if(value == null){
      return;
    }

    //try casting to bool
    if(value == "true" || value == "True"){
      newJson[key] = true;
      return;
    } else if (value == "false" || value == "False"){
      newJson[key] = false;
      return;
    }
    //try casting to int
    newJson[key] = int.parse(value.toString());
  });

  return newJson;
}