import requests
import sys
import csv
import random 
from bs4 import BeautifulSoup
 
# LIMIT = 10 # Valid values: 10, 20, 30, 40, 50, and 100

USER_AGENTS = [
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36',
]

class query4:
    def make_request(searchTerm):
        assert isinstance(searchTerm, str), 'Search term must be a string'
        escaped_search_term = searchTerm.replace(' ', '+')
        escaped_search_term+='+agriculture'
        location = 'mumbai'
        google_url = 'https://www.google.com/search?tbm=lcl&q={}&near={}&tbs=lrf:!1m4!1u3!2m2!3m1!1e1!1m4!1u2!2m2!2m1!1e1!2m1!1e3!2m4!1e2!5m2!2m1!2e7,lf:1,lf_ui:2&rlst=f'.format(escaped_search_term, location)
        response = requests.get(google_url, headers={'User-Agent': random.choice(USER_AGENTS)})
        response.raise_for_status() 
        return response.content

    def parse_content(html):
        soup = BeautifulSoup(html,'html.parser')
        results = []
        # items = soup.find_all("div",class_="")[ 'sh-dgr__gr-auto','sh-pr__grid-result']
        items = soup.findAll("div", {'class':'VkpGBb'})
        for item in items:  
            name = item.find("div", {'role': 'heading'}).div.text
        
            rating = item.find("g-review-stars").span.get('aria-label')
        
            directions = item.findAll('a')[-1].get('data-url')
        
            address = item.find("div", {'role':"heading"}).findNext('span').div.findNext('div').span.span.text
            
            directions = item.findAll('a')[-1].get('data-url')
            results.append({'name': name, 'rating': rating, 'address': address,'directions': directions})
        
        return results