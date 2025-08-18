import 'package:prize_lottery_app/base/model/item_census.dart';

///
class CensusValue {
  ///
  late List<List<int>> values;

  CensusValue.fromJson(List json) {
    values = json.map((e) {
      List item = e;
      return item.map((e) => int.parse(e)).toList();
    }).toList();
  }

  ///
  /// 下标是否从零开始
  List<List<ItemCensus>> parse({required bool zero, required bool reverse}) {
    List<List<ItemCensus>> items = <List<ItemCensus>>[];
    for (List<int> value in values) {
      List<ItemCensus> itemI = [];
      for (int i = 0; i < value.length; i++) {
        itemI.add(ItemCensus(key: zero ? i : i + 1, value: value[i]));
      }
      itemI.sort(
          (ii, ij) => reverse ? (ii.value - ij.value) : (ij.value - ii.value));
      items.add(itemI);
    }
    return items;
  }
}
