from model import Purchase, Session


class PurchasesController:
    def add_purchase(self, user, product, quantity, session=None):
        own_session = False
        if not session:
            session = Session()
            own_session = True

        purchase = Purchase(user, product, quantity)
        session.add(purchase)

        if own_session:
            session.commit()
            session.close()
