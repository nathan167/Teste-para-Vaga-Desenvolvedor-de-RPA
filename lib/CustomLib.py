import requests
import json
from urllib.parse import quote
import csv

def search_clan(token, name_of_clan, locationId, tag):
    # request
    headers = {'Authorization': 'Bearer {}'.format(token)}
    payload = {'name': name_of_clan, 'locationId': locationId}
    r = requests.get('https://api.clashroyale.com/v1/clans', params=payload, headers=headers)
    a = r.text
    print(a)
    # tratamento do response
    dict1 = json.loads(a)
    dict2 = dict1['items']
    print(dict1)
    # filtrando tag
    for item in dict2:
        if tag[:5] == item['tag'][:5]:
            tag = item['tag']
            return tag


def search_members(token, tag):
    tag = quote(tag)
    headers = {'Authorization': 'Bearer {}'.format(token)}
    payload = {'name': tag}
    url = ('https://api.clashroyale.com/v1/clans/' + tag + '/members')
    r = requests.get(url, params=payload, headers=headers)
    a = r.text
    members = json.loads(a)
    return members


def write_csv(filename, members):
    with open(filename, 'w', encoding="utf-8") as f:
        w = csv.writer(f)
        for item in members['items']:
            text = [str(item['name']), str(item['expLevel']), str(item['trophies']), str(item['role'])]
            w.writerow(text)
    return filename
