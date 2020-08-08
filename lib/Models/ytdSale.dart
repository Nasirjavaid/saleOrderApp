class YTDSale {
  String month;
  int amount;

  YTDSale({this.month, this.amount});

  YTDSale.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['amount'] = this.amount;
    return data;
  }
}