from model import Session, User

DAYS_IN_MONTH = 365.25 / 12


class UserController:
    def get_user_by_id(self, user_id, session=None):
        own_session = False
        if not session:
            session = Session()
            own_session = True

        user = session.query(User).filter(
                User.greenlist_uuid == user_id).one_or_none()
        if own_session:
            session.close()
        return user

    def get_challenge_duration_in_months(self, user):
        time_diff = user.challenge_end_ts - user.challenge_start_ts
        return round(time_diff.days / DAYS_IN_MONTH)
