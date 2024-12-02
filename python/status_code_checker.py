import threading
import requests

# requires: requests
# install: python3 -m pip install requests

websites = ["https://geia.pjc.mt.gov.br"]


def status_code(site):
    try:
        result = requests.get(site)
        print("[*] " + site + " " + str(result.status_code))
    except requests.exceptions.ConnectionError as e:
        print("[*] " + site + " " + str(e[0][0]))


for site in websites:
    t = threading.Thread(target=status_code, args=(site,))
    t.start()