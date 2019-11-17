from controllers.user import UserController
from model import Session

TREE_CO2_GRAMS_PER_MONTH = 1500


class TreesController:
    def co2_difference_to_trees(self, user, original, alternative, session=None):
        own_session = False
        if not session:
            session = Session()
            own_session = True

        challenge_months = (
                UserController().get_challenge_duration_in_months(user))
        tree_co2_equivalent = TREE_CO2_GRAMS_PER_MONTH * challenge_months
        saved_trees = (original - alternative) / tree_co2_equivalent

        if own_session:
            session.close()
        return saved_trees
