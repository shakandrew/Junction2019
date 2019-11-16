from model import Product, ProductSize, Session


class SuggestionController:
    def get_suggestions(self, product):
        session = Session()

        bigger_sizes = (self._session
                        .query(Product, ProductSize)
                        .filter(ProductSize.smallest_id == product.id)
                        .filter(Product.id == ProductSize.product_id)
                        .all())
        bigger_sizes = [product for (product, _) in bigger_sizes]

        same_class = (self._session
                      .query(Product)
                      .filter(Product.product_cl_id == product.product_cl_id)
                      .filter(Product.product_id != product.product_id)
                      .all())

        session.close()
        return bigger_sizes + same_class
