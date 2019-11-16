import json
from flask import Flask, abort, request, make_response
from flask_restful import Api, Resource
from controllers.challenge import ChallengeController
from controllers.greenlist import GreenListController
from controllers.suggestion import SuggestionController
from controllers.product import ProductController

app = Flask(__name__)

api = Api(app)


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
    def get(self, product_id):
        # try:
        #     session = Session()
        #     product = ProductController().get_product(product_id, session)
        #     if not product:
        #         abort(404)
        #     suggestions = SuggestionController().get_suggestions(
        #             product, session)
        #
        #
        # except Exception as e:
        #     pass
        # finally:
        #     session.close()
        pass


class Purchase(Resource):
    def post(self):
        try:
            pass
        except Exception as e:
            pass


api.add_resource(Challenge, '/challenge')
api.add_resource(GreenList, '/greenList')
api.add_resource(ProductSuggestions, '/productSuggestions/<product_id>')
api.add_resource(Purchase, '/purchases')

if __name__ == '__main__':
    app.run(debug=True)
