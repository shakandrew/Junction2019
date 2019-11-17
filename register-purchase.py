import requests
import click

HOST = 'http://localhost:5000'
USER_ID = 'asdfsdafsdaf'

PRODUCT_IDS = {
        'detergent': 2,
        'chocolate': 4,
}


@click.command()
@click.option('--item', type=click.Choice(['detergent', 'chocolate']))
@click.option('--quantity', type=int)
def register_purchase(item, quantity):
    payload = {
            'userId': USER_ID,
            'productId': PRODUCT_IDS[item],
            'quantity': quantity,
    }
    requests.post(HOST + '/purchases', json=payload)


if __name__ == '__main__':
    register_purchase()
