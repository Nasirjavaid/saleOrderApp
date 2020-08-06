class Summary {
  double todaySale;
  double mtd;
  int ytd;
  double receiveable;
  double pendingSO;
  Months months;

  Summary(
      {this.todaySale,
      this.mtd,
      this.ytd,
      this.receiveable,
      this.pendingSO,
      this.months});

  Summary.fromJson(Map<String, dynamic> json) {
    todaySale = json['todaySale'];
    mtd = json['mtd'];
    ytd = json['ytd'];
    receiveable = json['receiveable'];
    pendingSO = json['pending_SO'];
    months =
        json['months'] != null ? new Months.fromJson(json['months']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['todaySale'] = this.todaySale;
    data['mtd'] = this.mtd;
    data['ytd'] = this.ytd;
    data['receiveable'] = this.receiveable;
    data['pending_SO'] = this.pendingSO;
    if (this.months != null) {
      data['months'] = this.months.toJson();
    }
    return data;
  }
}

class Months {
  int m1;
  double m2;
  double m3;
  int m4;
  int m5;
  int m6;
  double m7;
  double m8;
  double m9;
  double m10;
  double m11;
  double m12;

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
      this.m12});

  Months.fromJson(Map<String, dynamic> json) {
    m1 = json['m1'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['m1'] = this.m1.toDouble();
    data['m2'] = this.m2.toDouble();
    data['m3'] = this.m3.toDouble();
    data['m4'] = this.m4.toDouble();
    data['m5'] = this.m5.toDouble();
    data['m6'] = this.m6.toDouble();
    data['m7'] = this.m7.toDouble();
    data['m8'] = this.m8.toDouble();
    data['m9'] = this.m9.toDouble();
    data['m10'] = this.m10.toDouble();
    data['m11'] = this.m11.toDouble();
    data['m12'] = this.m12.toDouble();
    return data;
  }
}
