class DeliveryOrder {
  int id;
  String name;
  int dO;
  String date;
  int balance;
  int balance_;
  int limit;
  int thisDO;
  List<Items> items;

  DeliveryOrder(
      {this.id,
      this.name,
      this.dO,
      this.date,
      this.balance,
      this.balance_,
      this.limit,
      this.thisDO,
      this.items});

  DeliveryOrder.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    dO = json['DO'];
    date = json['Date'];
    balance = json['Balance'];
    balance_ = json['Balance_'];
    limit = json['Limit'];
    thisDO = json['This_DO'];
    if (json['Items'] != null) {
      items = new List<Items>();
      json['Items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['DO'] = this.dO;
    data['Date'] = this.date;
    data['Balance'] = this.balance;
    data['Balance_'] = this.balance_;
    data['Limit'] = this.limit;
    data['This_DO'] = this.thisDO;
    if (this.items != null) {
      data['Items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int id;
  String itemName;
  double saleAmount;
  double rate;
  double qty;
  double uom;

  Items({this.id, this.itemName, this.saleAmount,this.rate,this.qty,this.uom});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['Item_Name'];
    saleAmount = json['Sale_Amount'];
    qty = json['qty'];
    uom = json['uom'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Item_Name'] = this.itemName;
    data['Sale_Amount'] = this.saleAmount;
    data["rate"] = this.rate;
    data['qty'] = this.qty;
    return data;
  }
}
