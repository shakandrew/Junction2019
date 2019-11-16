import json
from flask import Flask, request
from flask_restful import Api, Resource
from controllers.challenge import ChallengeController

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
            pass
        except Exception as e:
            pass


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
