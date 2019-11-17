class Product {
  int id;
  String name;
  String picture;
  int footprint;
  int multiple;
  List<Product> alternatives;
  double treesDifference;

  Product({
    this.id,
    this.name,
    this.picture,
    this.footprint,
    this.multiple,
    this.alternatives,
    this.treesDifference,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    picture = json['picture'] != null ? json['picture'] : json['image'];
    footprint = json['footprint'];
    multiple = json['multiple'];
    if (json['alternatives'] != null) {
      alternatives = new List<Product>();
      json['alternatives'].forEach((v) {
        alternatives.add(new Product.fromJson(v));
      });
    }
    treesDifference = json['treesDifference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['picture'] = this.picture;
    data['footprint'] = this.footprint;
    data['multiple'] = this.multiple;
    if (this.alternatives != null) {
      data['alternatives'] = this.alternatives.map((v) => v.toJson()).toList();
    }
    data['treesDifference'] = this.treesDifference;
    return data;
  }
}
