class Summary {
  int id;
  int mTD;
  int yTD;
  int receivable;
  int pendingSO;
  int jan;
  int feb;
  int mar;
  int apr;
  int may;
  int jun;
  int jul;
  int aug;
  int sep;
  int oct;
  int nov;
  int dec;

  Summary(
      {this.id,
      this.mTD,
      this.yTD,
      this.receivable,
      this.pendingSO,
      this.jan,
      this.feb,
      this.mar,
      this.apr,
      this.may,
      this.jun,
      this.jul,
      this.aug,
      this.sep,
      this.oct,
      this.nov,
      this.dec});

  Summary.fromJson(Map<String, dynamic> json) {
    id =json['id'];
    mTD = json['MTD'];
    yTD = json['YTD'];
    receivable = json['Receivable'];
    pendingSO = json['Pending_SO'];
    jan = json['Jan'];
    feb = json['Feb'];
    mar = json['Mar'];
    apr = json['Apr'];
    may = json['May'];
    jun = json['Jun'];
    jul = json['Jul'];
    aug = json['Aug'];
    sep = json['Sep'];
    oct = json['Oct'];
    nov = json['Nov'];
    dec = json['Dec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['MTD'] = this.mTD;
    data['YTD'] = this.yTD;
    data['Receivable'] = this.receivable;
    data['Pending_SO'] = this.pendingSO;
    data['Jan'] = this.jan;
    data['Feb'] = this.feb;
    data['Mar'] = this.mar;
    data['Apr'] = this.apr;
    data['May'] = this.may;
    data['Jun'] = this.jun;
    data['Jul'] = this.jul;
    data['Aug'] = this.aug;
    data['Sep'] = this.sep;
    data['Oct'] = this.oct;
    data['Nov'] = this.nov;
    data['Dec'] = this.dec;
    return data;
  }
}