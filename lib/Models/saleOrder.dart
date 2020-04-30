class SaleOrder {
   int id;
  String name;
  int sO;
  String date;
  int balance;
  int balance_;
  int limit;
  int thisSO;
  List<Items> items;

  SaleOrder(
      {this.id,
        this.name,
      this.sO,
      this.date,
      this.balance,
      this.balance_,
      this.limit,
      this.thisSO,
      this.items});

  SaleOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    sO = json['SO#'];
    date = json['Date'];
    balance = json['Balance'];
    balance_ = json['Balance_'];
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
    data['id'] = this.id;
    data['Name'] = this.name;
    data['SO#'] = this.sO;
    data['Date'] = this.date;
    data['Balance'] = this.balance;
    data['Balance_'] = this.balance_;
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
  String itemName;
  int saleAmount;
  
  Items({this.id,this.itemName, this.saleAmount});

  Items.fromJson(Map<String, dynamic> json) {
     id = json['id'];
    itemName = json['Item_Name'];
    saleAmount = json['Sale_Amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] =this.id;
    data['Item_Name'] = this.itemName;
    data['Sale_Amount'] = this.saleAmount;
    return data;
  }
}