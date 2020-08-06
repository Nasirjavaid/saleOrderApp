class DeliveryChallan {
  int dcId;
  int dcNo;
  String dcDate;
  String customerName;
  int thisDC;
  int limit;
  int balance;
  int balanceAfterDC;
  List<Items> items;

  DeliveryChallan(
      {this.dcId,
      this.dcNo,
      this.dcDate,
      this.customerName,
      this.thisDC,
      this.limit,
      this.balance,
      this.balanceAfterDC,
      this.items});

  DeliveryChallan.fromJson(Map<String, dynamic> json) {
    dcId = json['dc_Id'];
    dcNo = json['dc_No'];
    dcDate = json['dc_Date'];
    customerName = json['customer_Name'];
    thisDC = json['this_DC'];
    limit = json['limit'];
    balance = json['balance'];
    balanceAfterDC = json['balance_After_DC'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dc_Id'] = this.dcId;
    data['dc_No'] = this.dcNo;
    data['dc_Date'] = this.dcDate;
    data['customer_Name'] = this.customerName;
    data['this_DC'] = this.thisDC;
    data['limit'] = this.limit;
    data['balance'] = this.balance;
    data['balance_After_DC'] = this.balanceAfterDC;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int dcId;
  int dcItemId;
  String itemName;
  String itemCode;
  String uom;
  int qty;

  Items(
      {this.dcId,
      this.dcItemId,
      this.itemName,
      this.itemCode,
      this.uom,
      this.qty});

  Items.fromJson(Map<String, dynamic> json) {
    dcId = json['dc_Id'];
    dcItemId = json['dc_Item_Id'];
    itemName = json['item_Name'];
    itemCode = json['item_Code'];
    uom = json['uom'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dc_Id'] = this.dcId;
    data['dc_Item_Id'] = this.dcItemId;
    data['item_Name'] = this.itemName;
    data['item_Code'] = this.itemCode;
    data['uom'] = this.uom;
    data['qty'] = this.qty;
    return data;
  }
}