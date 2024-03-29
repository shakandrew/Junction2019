from model import Session, UserList, User, Product


class GreenListController:
    def __init__(self):
        pass

    @staticmethod
    def get_list(uuid):
        session = Session()
        resp = []
        user = session.query(User).filter(User.greenlist_uuid == uuid).one_or_none()
        for elem in session.query(UserList).filter(UserList.user_id == user.id).all():
            resp.append({
                "productId": elem.product.id,
                "name": elem.product.name,
                "footprint": elem.product.footprint,
                "image": elem.product.image
            })
        session.close()
        return resp

    @staticmethod
    def add_to_list(uuid, product_id, trees_difference):
        msg = "Success"
        try:
            session = Session()
            user = session.query(User).filter(User.greenlist_uuid == uuid).one_or_none()
            if session.query(UserList).filter(
                    UserList.user_id == user.id).filter(UserList.product_id == product_id).first() is None:
                product = session.query(Product).filter(Product.id == product_id).one_or_none()
                product_to_user = UserList(user, product, trees_difference)
                session.add(product_to_user)
                session.commit()
            session.close()
        except Exception as e:
            msg = e
        finally:
            return msg
