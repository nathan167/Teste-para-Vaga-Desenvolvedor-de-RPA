from requests import get

def get_my_ip():
    endpoint = 'http://api.ipify.org/'
    ip = get(endpoint).text
    print(ip)
    return ip