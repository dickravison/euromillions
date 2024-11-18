import requests
import os
import boto3
from bs4 import BeautifulSoup

URL = "https://www.national-lottery.co.uk/games/euromillions"
SNS_TOPIC = os.environ['SNS_TOPIC']
SNS_CLIENT = boto3.client('sns')
THRESHOLD = 100
NOTIFICATIONS_ENABLED = os.environ.get('NOTIFICATIONS_ENABLED')

def publish(message):
    SNS_CLIENT.publish(
        TopicArn = os.environ['SNS_TOPIC'],
        Subject = "Euromillions",
        Message = message
    )
    print(message)

def main(event, context):
    page = requests.get(URL)
    soup = BeautifulSoup(page.content, 'html.parser')
    jackpot = soup.find('span', class_='amount')
    jackpot = jackpot.contents[0].strip().replace('£', '')
    if int(jackpot) > THRESHOLD:
        message = "The Euromillions jackpot tonight is <b>£" + jackpot + " million</b>."
        print(message)
        if NOTIFICATIONS_ENABLED:
            publish(message)
        else:
            print("Notifications disabled.")
    else:
        print("The jackpot is not above the set threshold.")
