class SaleOrder {
  int saleOrderId;
  int saleOrderNo;
  String soDate;
  String customerName;
  int thisSO;
  int limit;
  int balance;
  int balanceAfterSo;
  List<Items> items;

  SaleOrder(
      {this.saleOrderId,
      this.saleOrderNo,
      this.soDate,
      this.customerName,
      this.thisSO,
      this.limit,
      this.balance,
      this.balanceAfterSo,
      this.items});

  SaleOrder.fromJson(Map<String, dynamic> json) {
    saleOrderId = json['sale_Order_Id'];
    saleOrderNo = json['sale_Order_No'];
    soDate = json['so_Date'];
    customerName = json['customer_Name'];
    thisSO = json['this_SO'];
    limit = json['limit'];
    balance = json['balance'];
    balanceAfterSo = json['balance_After_So'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_Order_Id'] = this.saleOrderId;
    data['sale_Order_No'] = this.saleOrderNo;
    data['so_Date'] = this.soDate;
    data['customer_Name'] = this.customerName;
    data['this_SO'] = this.thisSO;
    data['limit'] = this.limit;
    data['balance'] = this.balance;
    data['balance_After_So'] = this.balanceAfterSo;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int saleOrderId;
  int saleOrderItemId;
  String itemName;
  String itemCode;
  String uom;
  int qty;
  var rate;
  int amount;

  Items(
      {this.saleOrderId,
      this.saleOrderItemId,
      this.itemName,
      this.itemCode,
      this.uom,
      this.qty,
      this.rate,
      this.amount});

  Items.fromJson(Map<String, dynamic> json) {
    saleOrderId = json['sale_Order_Id'];
    saleOrderItemId = json['sale_Order_Item_Id'];
    itemName = json['item_Name'];
    itemCode = json['item_Code'];
    uom = json['uom'];
    qty = json['qty'];
    rate = json['rate'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_Order_Id'] = this.saleOrderId;
    data['sale_Order_Item_Id'] = this.saleOrderItemId;
    data['item_Name'] = this.itemName;
    data['item_Code'] = this.itemCode;
    data['uom'] = this.uom;
    data['qty'] = this.qty;
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    return data;
  }
}