class SaleOrder {
  int saleOrderId;
  int sO;
  String name;
  String date;
  int balance;
  int balance_;
  int limit;
  int thisSO;
  List<Items> items;

  SaleOrder(
      {this.saleOrderId,
      this.sO,
      this.name,
      this.date,
      this.balance,
      this.balance_,
      this.limit,
      this.thisSO,
      this.items});

  SaleOrder.fromJson(Map<String, dynamic> json) {
    saleOrderId = json['sale_order_id'];
    sO = json['SO'];
    name = json['Name'];
    date = json['Date'];
    balance = json['Balance'];
    balance = json['Balance_'];
    limit = json['Limit'];
    thisSO = json['This_SO'];
    if (json['Items'] != null) {
      items = new List<Items>();
      json['Items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_order_id'] = this.saleOrderId;
    data['SO'] = this.sO;
    data['Name'] = this.name;
    data['Date'] = this.date;
    data['Balance'] = this.balance;
    data['Balance_'] = this.balance;
    data['Limit'] = this.limit;
    data['This_SO'] = this.thisSO;
    if (this.items != null) {
      data['Items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int id;
  double saleAmount;
  String itemName;
  String iTEMCODE;

  Items({this.id, this.saleAmount, this.itemName, this.iTEMCODE});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    saleAmount = json['Sale_Amount'];
    itemName = json['Item_Name'];
    iTEMCODE = json['ITEM_CODE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Sale_Amount'] = this.saleAmount;
    data['Item_Name'] = this.itemName;
    data['ITEM_CODE'] = this.iTEMCODE;
    return data;
  }
}