from sqlalchemy import or_

from controllers.trees import TreesController
from model import Product, ProductSize, Session, UserList


class Suggestion:
    def __init__(self, alternative_product, trees_difference, multiplier=None):
        self.alternative_product = alternative_product
        self.trees_difference = trees_difference
        self.multiplier = multiplier


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

    def get_suggestions(self, user, product, session=None):
        own_session = False
        if not session:
            session = Session()
            own_session = True

        already_in_list = (session
                           .query(UserList)
                           .filter(UserList.user_id == user.id)
                           .all())
        already_in_list = set(p.product_id for p in already_in_list)

        results = []

        bigger_sizes = (session
                        .query(Product, ProductSize)
                        .filter(ProductSize.smallest_id == product.id)
                        .filter(Product.id == ProductSize.product_id)
                        .filter(Product.id != product.id)
                        .all())
        for alternative, product_size in bigger_sizes:
            multiplier = product_size.multiplier
            trees_difference = (
                    TreesController().co2_difference_to_trees(
                        user,
                        product.footprint * multiplier,
                        alternative.footprint))
            if alternative.id not in already_in_list:
                suggestion = Suggestion(
                        alternative, trees_difference, multiplier)
                results.append(suggestion)

        same_class = (session
                      .query(Product)
                      .filter(Product.product_cl_id == product.product_cl_id)
                      .filter(Product.id != product.id)
                      .all())

        for alternative in same_class:
            trees_difference = (
                    TreesController().co2_difference_to_trees(
                        user, product.footprint, alternative.footprint))
            if alternative.id not in already_in_list:
                suggestion = Suggestion(alternative, trees_difference)
                results.append(suggestion)

        if own_session:
            session.close()
        return results
