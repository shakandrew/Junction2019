from model import User, Session
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
            "startTime": user.challenge_start_ts,
            "endTime": user.challenge_end_ts,
            "score": user.challenge_score
        }
        session.close()
        return resp

    @staticmethod
    def create_challenge(uuid, duration):
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
        return "Success"
