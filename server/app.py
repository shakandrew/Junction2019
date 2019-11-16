from flask import Flask, request
from flask_restful import Api, Resource

app = Flask(__name__)

api = Api(app)


class Challenge(Resource):
    def get(self):
        pass

    def post(self):
        pass


class GreenList(Resource):
    def get(self):
        pass

    def post(self):
        pass


class ProductSuggestions(Resource):
    def get(self):
        pass


class Purchase(Resource):
    def post(self):
        pass


api.add_resource(Challenge)

if __name__ == '__main__':
    app.run(debug=True)
