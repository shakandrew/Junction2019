from model import Product, Session


class ProductController:
    def get_product(self, product_id, session=None):
        own_session = False
        if not session:
            session = Session()
            own_session = True

        product = (session
                   .query(Product)
                   .filter(Product.id == product_id)
                   .first())

        if own_session:
            session.close()
        return product
