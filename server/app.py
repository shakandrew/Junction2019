import json
from flask import Flask, abort, request, make_response
from flask_restful import Api, Resource
from controllers.challenge import ChallengeController
from controllers.greenlist import GreenListController
from controllers.suggestion import SuggestionController
from controllers.product import ProductController
from controllers.user import UserController
from model import Session

app = Flask(__name__)

api = Api(app)

with open('config.json') as json_data_file:
    config = json.load(json_data_file)
config = config["server"]


class Challenge(Resource):
    def get(self):
        try:
            uuid = request.headers["GreenList-User-Id"]
            response = ChallengeController.get_challenge(uuid)
            return make_response(json.dumps(response))
        except Exception as e:
            pass

    def post(self):
        try:
            uuid = request.headers["GreenList-User-Id"]
            duration = request.get_json()['duration']
            response = ChallengeController.create_challenge(uuid, duration)
            return make_response(json.dumps(response))
        except Exception as e:
            pass


class GreenList(Resource):
    def get(self):
        try:
            uuid = request.headers["GreenList-User-Id"]
            response = GreenListController.get_list(uuid)
            return make_response(json.dumps(response))
        except Exception as e:
            pass

    def post(self):
        try:
            uuid = request.headers["GreenList-User-Id"]
            product_id = request.get_json()["productId"]
            response = GreenListController.add_to_list(uuid, product_id)
            return make_response(json.dumps(response))
        except Exception as e:
            pass


class ProductSuggestions(Resource):
    def get(self):
        try:
            session = Session()
            uuid = request.headers["GreenList-User-Id"]
            user = UserController().get_user_by_id(uuid, session)
            if not user:
                abort(401)
            products = (
                    SuggestionController().get_suboptimal_products(session))
            result = []
            for product in products:
                product_json = self.product_to_json(product)

                suggestions = SuggestionController().get_suggestions(
                        user, product, session)

                alternatives = [self.suggestion_to_json(suggestion)
                                for suggestion in suggestions]

                product_json.update({'alternatives': alternatives})
                result.append(product_json)
            return result
        finally:
            session.close()

    def product_to_json(self, product, multiple=None):
        result = {
                'id': product.id,
                'name': product.name,
                'picture': product.image,
                'footprint': product.footprint,
        }
        if multiple:
            result.update({'multiple': multiple})
        return result

    def suggestion_to_json(self, suggestion):
        result = self.product_to_json(suggestion.alternative_product)
        result.update({'treesDifference': suggestion.trees_difference})
        if suggestion.multiplier:
            result.update({'multiple': suggestion.multiplier})
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
    app.run(debug=True, host=config["host"], port=config["port"])
