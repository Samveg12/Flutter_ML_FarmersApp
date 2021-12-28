import requests
import sys
import csv
import random 
from bs4 import BeautifulSoup
 
# LIMIT = 10 # Valid values: 10, 20, 30, 40, 50, and 100
USER_AGENTS = [
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36',
]
class query3:

    def make_request(searchTerm):
        assert isinstance(searchTerm, str), 'Search term must be a string'
        escaped_search_term = searchTerm.replace(' ', '+')
        escaped_search_term+='+agriculture+in+india'
        limit = 3
        google_url = 'https://www.google.com/search?tbm=shop&q={}&num={}&tbs=vw:g'.format(escaped_search_term, limit)
        response = requests.get(google_url, headers={'User-Agent': random.choice(USER_AGENTS)})
        response.raise_for_status() 

        # print(response.content)
    
        return response.content

    def parse_content(html):
        soup = BeautifulSoup(html,'html.parser')
        results = []
        # items = soup.find_all("div",class_="")[ 'sh-dgr__gr-auto','sh-pr__grid-result']
        items = soup.findAll("div", {'class':'sh-dgr__content'})
        for item in items:  
            price = item.find("span", {'class': 'kHxwFf'}).span.span.text
            price = price[1:]
            seller = item.find('a').text
            name = item.find('h4', attrs={'class': 'A2sOrd'}).text
            # link = item.find("div", {'class':'sh-dgr__thumbnail'}).a.get('href')
            starsDiv = item.find('div', attrs={'class': '_OBj'})
            reviewsSpan = item.find('span', attrs={'class': '_Ezj'})
            reviews = 0
            if reviewsSpan:
                reviews = reviewsSpan.findNext('span').text
            stars = 0
            if starsDiv:
                stars = starsDiv['aria-label']
            results.append({'name': name, 'price': price, 'seller': seller, 'reviews': reviews,'stars': stars})
            # print({'name': name, 'price': price, 'seller': seller, 'reviews': reviews,'stars': stars})
        #print(results)
        return results

          

    
    
    

            




