import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:greenlist/models/index.dart';
import 'package:greenlist/styles.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function onTap;
  ProductCard({this.product, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: onTap != null ? 0 : 10),
      child: Card(
        elevation: onTap != null ? 0 : 6,
        margin: onTap != null ? EdgeInsets.all(0) : null,
        child: Container(
          height: 130,
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Container(
                width: 130,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(product.picture),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              product.name,
                              style: genTextStyle(null, null, mediumWeight),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          Text(
                            "CO2: ${product.footprint}g",
                            style: genTextStyle(),
                          ),
                          Spacer(),
                          if (product.multiple != null && product.multiple > 1)
                            Text(
                              "Count: ${product.multiple}",
                              style: genTextStyle(),
                            ),
                          SizedBox(width: 15),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Spacer(),
                          if (onTap != null)
                            InkWell(
                              onTap: onTap,
                              child: Chip(
                                backgroundColor: greenColor,
                                label: Text(
                                  "Add to GreenList",
                                  style: genTextStyle(blackColor),
                                ),
                              ),
                            ),
                          SizedBox(width: 15),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
