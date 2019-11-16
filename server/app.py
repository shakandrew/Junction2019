import json
from flask import Flask, abort, request
from flask_restful import Api, Resource
from controllers.challenge import ChallengeController
from controllers.suggestion import SuggestionController
from controllers.product import ProductController

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
    def get(self, product_id):
        try:
            session = Session()
            product = ProductController().get_product(product_id, session)
            if not product:
                abort(404)
            suggestions = SuggestionController().get_suggestions(
                    product, session)


        except Exception as e:
            pass
        finally:
            session.close()


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
