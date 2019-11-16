from sqlalchemy import Column, Integer, String, DateTime, ForeignKey
from sqlalchemy.orm import backref, relation
from sqlalchemy.ext.declarative import declarative_base

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


class ProductSizes(Base):
    __tablename__ = 'product_size'
    product_id = Column('product_id', Integer, ForeignKey('product.id'))
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
    product_cl_id = Column('product_cl_id', Integer, ForeignKey('user.id'))
    image = Column('image', String(255))

    product_cl = relation(ProductCl, backref=backref('snippets', lazy='dynamic'))

    def __init__(self, name, footprint, product_cl_id, image):
        self.name = name
        self.footprint = footprint
        self.product_cl_id = product_cl_id
        self.image = image


class Purchase(Base):
    __tablename__ = 'purchase'
    id = Column('id', Integer, primary_key=True)
    user_id = Column('name', Integer, ForeignKey('user.id'))
    product_id = Column('name', Integer, ForeignKey('product.id'))
    quantity = Column('quantity', Integer)

    user = relation(User, backref=backref('snippets', lazy='dynamic'))
    product = relation(Product, backref=backref('snippets', lazy='dynamic'))

    def __init__(self, user, product, quantity):
        self.user = user
        self.product = product
        self.quantity = quantity
