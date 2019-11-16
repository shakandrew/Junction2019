import json
from flask import Flask, request
from flask_restful import Api, Resource
from controllers.challenge import ChallengeController
from controllers.suggestion import SuggestionController
from controllers.product import ProductController
from model import Session

app = Flask(__name__)

api = Api(app)


class Challenge(Resource):
    def get(self):
        try:
            data = request.get_json()
            response = ChallengeController.get_challenge(data["uuid"])
            return json.dumps(response)
        except Exception as e:
            pass

    def post(self):
        try:
            data = request.get_json()
            response = ChallengeController.create_challenge(data['uuid'], data['duration'])
            return json.dumps(response)
        except Exception as e:
            pass


class GreenList(Resource):
    def get(self):
        try:
            pass
        except Exception as e:
            pass

    def post(self):
        try:
            pass
        except Exception as e:
            pass


class ProductSuggestions(Resource):
    def get(self):
        try:
            session = Session()
            products = (
                    SuggestionController().get_suboptimal_products(session))
            result = []
            for product in products:
                product_json = self.product_to_json(product)

                bigger_sizes, same_class = (
                        SuggestionController()
                        .get_suggestions(product, session))

                alternatives = []
                alternatives.extend([
                    self.product_to_json(product)
                    for product in same_class])
                alternatives.extend([
                    self.product_to_json(product, multiple)
                    for (product, multiple) in bigger_sizes])

                product_json.update({'alternatives': alternatives})
                result.append(product_json)
            return result
        finally:
            session.close()

    def product_to_json(self, product, multiple=None):
        result = {
                'id': product.id,
                'name': product.name,
                'picture': 'STUB',
                'footprint': product.footprint,
        }
        if multiple:
            result.update({'multiple': multiple})
        return result


class Purchase(Resource):
    def post(self):
        try:
            pass
        except Exception as e:
            pass


api.add_resource(Challenge, '/challenge')
api.add_resource(GreenList, '/greenList')
api.add_resource(ProductSuggestions, '/productSuggestions')
api.add_resource(Purchase, '/purchases')

if __name__ == '__main__':
    app.run(debug=True)
