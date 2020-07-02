class Summary {
  double mTD;
  double yTD;
  double receiveable;
  double pendingSO;
  Months months;
  double todaySale;

  Summary(
      {this.mTD,
      this.yTD,
      this.receiveable,
      this.pendingSO,
      this.months,
      this.todaySale});

  Summary.fromJson(Map<String, dynamic> json) {
    mTD = json['MTD'];
    yTD = json['YTD'];
    receiveable = json['Receiveable'];
    pendingSO = json['Pending_SO'];
    todaySale = json['todaySale'];
    months =
        json['Months'] != null ? new Months.fromJson(json['Months']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MTD'] = this.mTD;
    data['YTD'] = this.yTD;
    data['Receiveable'] = this.receiveable;
    data['Pending_SO'] = this.pendingSO;
    data['todaySale'] = this.todaySale;
    if (this.months != null) {
      data['Months'] = this.months.toJson();
    }
    return data;
  }
}

class Months {
  double m1;
  double m2;
  double m3;
  double m4;
  double m5;
  double m6;
  double m7;
  double m8;
  double m9;
  double m10;
  double m11;
  double m12;
  double netBalance;

  Months(
      {this.m1,
      this.m2,
      this.m3,
      this.m4,
      this.m5,
      this.m6,
      this.m7,
      this.m8,
      this.m9,
      this.m10,
      this.m11,
      this.m12,
      this.netBalance});

  Months.fromJson(Map<String, dynamic> json) {
    m1 = json['m1 '];
    m2 = json['m2'];
    m3 = json['m3'];
    m4 = json['m4'];
    m5 = json['m5'];
    m6 = json['m6'];
    m7 = json['m7'];
    m8 = json['m8'];
    m9 = json['m9'];
    m10 = json['m10'];
    m11 = json['m11'];
    m12 = json['m12'];
    netBalance = json['Net_Balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['m1'] = this.m1;
    data['m2'] = this.m2;
    data['m3'] = this.m3;
    data['m4'] = this.m4;
    data['m5'] = this.m5;
    data['m6'] = this.m6;
    data['m7'] = this.m7;
    data['m8'] = this.m8;
    data['m9'] = this.m9;
    data['m10'] = this.m10;
    data['m11'] = this.m11;
    data['m12'] = this.m12;
    data['Net_Balance'] = this.netBalance;
    return data;
  }
}
