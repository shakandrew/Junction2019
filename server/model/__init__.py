import json
from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, create_engine
from sqlalchemy.orm import backref, relation, sessionmaker
from sqlalchemy.ext.declarative import declarative_base

with open('config.json') as json_data_file:
    config = json.load(json_data_file)
config = config["db"]

# engine = create_engine('mysql+pymysql://greenlist:green8276pass@localhost:3310/greenlist')
engine = create_engine("{}://{}:{}@{}:{}/{}".format(config["driver"], config["username"], config["password"],
                                                    config["host"], config["port"], config["name"]))
Session = sessionmaker(bind=engine)
Base = declarative_base()


class User(Base):
    __tablename__ = 'user'
    id = Column('id', Integer, primary_key=True)
    greenlist_uuid = Column('greenlist_uuid', String(255))
    challenge_start_ts = Column('challenge_start_ts', DateTime)
    challenge_end_ts = Column('challenge_end_ts', DateTime)
    challenge_score = Column('challenge_score', Integer)

    def __init__(self, greenlist_uuid, challenge_start_ts, challenge_end_ts, challenge_score):
        self.greenlist_uuid = greenlist_uuid
        self.challenge_start_ts = challenge_start_ts
        self.challenge_end_ts = challenge_end_ts
        self.challenge_score = challenge_score

    def __eq__(self, other):
        return type(self) is type(other) and self.id == other.id

    def __ne__(self, other):
        return not self.__eq__(other)


class ProductCl(Base):
    __tablename__ = "product_cl"
    id = Column('id', Integer, primary_key=True)
    name = Column('name', String(45))

    def __init__(self, name):
        self.name = name


class ProductSize(Base):
    __tablename__ = 'product_size'
    product_id = Column('product_id', Integer, ForeignKey('product.id'),
                        primary_key=True)
    smallest_id = Column('smallest_id', Integer, ForeignKey('product.id'))
    multiplier = Column('multiplier', Integer)

    def __init__(self, product_id, smallest_id, multiplier):
        self.product_id = product_id
        self.smallest_id = smallest_id
        self.multiplier = multiplier


class Product(Base):
    __tablename__ = 'product'
    id = Column('id', Integer, primary_key=True)
    name = Column('name', String(45))
    footprint = Column('footprint', Integer)
    product_cl_id = Column('product_cl_id', Integer, ForeignKey('product_cl.id'))
    image = Column('image', String(255))

    product_cl = relation(ProductCl, backref=backref('product_cl', lazy='dynamic'))

    def __init__(self, name, footprint, product_cl_id, image):
        self.name = name
        self.footprint = footprint
        self.product_cl_id = product_cl_id
        self.image = image


class UserList(Base):
    __tablename__ = 'user_list'
    id = Column('id', Integer, primary_key=True)
    user_id = Column('user_id', Integer, ForeignKey('user.id'))
    product_id = Column('product_id', Integer, ForeignKey('product.id'))

    user = relation(User, backref=backref('user_list', lazy='dynamic'))
    product = relation(Product, backref=backref('user_list', lazy='dynamic'))

    def __init__(self, user, product):
        self.user = user
        self.product = product


class Purchase(Base):
    __tablename__ = 'purchase'
    id = Column('id', Integer, primary_key=True)
    user_id = Column('user_id', Integer, ForeignKey('user.id'))
    product_id = Column('product_id', Integer, ForeignKey('product.id'))
    quantity = Column('quantity', Integer)

    user = relation(User, backref=backref('purchase', lazy='dynamic'))
    product = relation(Product, backref=backref('purchase', lazy='dynamic'))

    def __init__(self, user, product, quantity):
        self.user = user
        self.product = product
        self.quantity = quantity
