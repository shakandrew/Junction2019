from sqlalchemy import or_

from controllers.product import ProductController
from model import Product, ProductSize, Session


class SuggestionController:
    def get_suboptimal_products(self, session=None):
        own_session = False
        if not session:
            session = Session()
            own_session = True

        products = (session
                    .query(Product)
                    .filter(or_(Product.id == 1, Product.id == 3))
                    .all())

        if own_session:
            session.close()
        return products

    def get_suggestions(self, product, session=None):
        own_session = False
        if not session:
            session = Session()
            own_session = True

        bigger_sizes = (session
                        .query(Product, ProductSize)
                        .filter(ProductSize.smallest_id == product.id)
                        .filter(Product.id == ProductSize.product_id)
                        .filter(Product.id != product.id)
                        .all())
        bigger_sizes = [
                (product, ps.multiplier)
                for (product, ps) in bigger_sizes]

        same_class = (session
                      .query(Product)
                      .filter(Product.product_cl_id == product.product_cl_id)
                      .filter(Product.id != product.id)
                      .all())

        if own_session:
            session.close()
        return (bigger_sizes, same_class)
