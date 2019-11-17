from model import User, Session, UserList, Purchase
from datetime import datetime, timedelta


class ChallengeController:
    def __init__(self):
        pass

    @staticmethod
    def get_challenge(uuid):
        session = Session()
        user = session.query(User).filter(User.greenlist_uuid == uuid).one_or_none()
        if user is None:
            raise Exception("There is no user [id={}]".format(uuid))
        resp = {
            "startTime": str(user.challenge_start_ts),
            "endTime": str(user.challenge_end_ts),
            "score": ChallengeController.score_calc(user)
        }
        session.close()
        return resp

    @staticmethod
    def create_challenge(uuid, duration):
        msg = "Success"
        try:
            session = Session()
            user = User(
                greenlist_uuid=uuid,
                challenge_start_ts=datetime.utcnow(),
                challenge_end_ts=datetime.utcnow() + timedelta(days=duration * 30),
                challenge_score=0
            )
            session.add(user)
            session.commit()
            session.close()
        except Exception as e:
            msg = e
        finally:
            return msg

    @staticmethod
    def score_calc(user):
        try:
            session = Session()
            score = 0
            score_product_list = session.query(UserList, Purchase).join(Purchase,
                                                                        Purchase.product_id == UserList.product_id
                                                                        ).filter(UserList.user == user).all()
            for product in score_product_list:
                score += product[0].trees_difference * product[1].quantity
            session.close()
            return round(score)
        except Exception as e:
            return e
