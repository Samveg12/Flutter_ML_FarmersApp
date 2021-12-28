import requests
import sys
import csv
import random 
from bs4 import BeautifulSoup
from commodities import commodities
from states import states
 
# LIMIT = 10 # Valid values: 10, 20, 30, 40, 50, and 100
USER_AGENTS = [
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36',
]
class query6:
    def make_request():
        searchTerm = "Maharashtra"
        commodity='0'
        assert isinstance(searchTerm, str), 'Search term must be a string'
        for state in states:
            for k,v in state.items():
                if k==searchTerm:
                    commodity=v
        escaped_search_term = searchTerm.replace(' ', '-')
        google_url = 'https://www.commodityonline.com/mandiprices/all/{}/0/{}'.format(escaped_search_term, commodity)
        response = requests.get(google_url, headers={'User-Agent': random.choice(USER_AGENTS)})
        response.raise_for_status() 
        return response.content

    def parse_content(html):
        soup = BeautifulSoup(html,'html.parser')
        results = []
        commodity = []
        market = []
        variety = []
        modalPrice = []
        j=0
        items = soup.findAll("div", {'class':'dt_ta_10'})
        for item in items:
            commodity.append(item.text)
            j+=1
        items = soup.findAll("div", {'class':'dt_ta_11'})
        for item in items:
            market.append(item.text)
        items = soup.findAll("div", {'class':'dt_ta_12'})
        for item in items:
            variety.append(item.text)
        items = soup.findAll("div", {'class':'dt_ta_14'})
        for item in items:
            modalPrice.append(item.text)

    
        results = [{'name':commodity[i], 'market':market[i], 'variety':variety[i],'modalPrice':modalPrice[i]} for i in range(j)]
    
        return results

 


    




