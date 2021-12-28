import requests
import sys
import csv
import random 
from bs4 import BeautifulSoup
import re 

# LIMIT = 10 # Valid values: 10, 20, 30, 40, 50, and 100

USER_AGENTS = [
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36',
]
 
def make_request(searchTerm):
    assert isinstance(searchTerm, str), 'Search term must be a string'
    escaped_search_term = searchTerm.replace(' ', '+')
    escaped_search_term+='+agriculture'
    limit = 10
    google_url = 'https://www.commodityonline.com/mandiprices/potato/haryana/168/13'
    response = requests.get(google_url, headers={'User-Agent': random.choice(USER_AGENTS)})
    response.raise_for_status() 
    print(google_url)
    # print(response.content)
 
    return response.content

def parse_content(html):
    soup = BeautifulSoup(html,'html.parser')
    results = []
    # items = soup.find_all("div",class_="")[ 'sh-dgr__gr-auto','sh-pr__grid-result']
    items = soup.findAll("select", {'id':'sel1'})[1].findAll('option')
    # print(items)
    for item in items:  
        option = item.text
        value = item.get('value')
        print(value)
        number = re.findall(".+/([0-9]+)$", value)
        if number:
            number = number[0]
        else:
            number='0'

        # value = item.get('value')

        results.append({option: number})
        # print({'name': name, 'price': price, 'seller': seller, 'reviews': reviews,'stars': stars})
    # print(results[1]);
    return results;

def write_to_csv(filename, data):
    with open(filename + '.csv', 'w', newline='', encoding='utf8') as file:
        writer = csv.writer(file)
        writer.writerow(data[0].keys())
        for item in data:
            writer.writerow(item.values())        

def parse_args():
    args = sys.argv
    length = len(args)
    if length < 2:
        print("No search term has been entered")
        sys.exit()
    if length > 2:
        print("I expect a single parameter dude")
        sys.exit()
    
    return args[1]

if __name__ == '__main__':
    searchTerm = parse_args()
    html = make_request(searchTerm)
    data = parse_content(html)
    if data:
        filename = searchTerm
        write_to_csv(filename, data)
        print(data)
    else:
        print("No data retrieve... maybe google ban :'( or try another search")
