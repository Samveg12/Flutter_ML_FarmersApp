import requests
import sys
import csv
import random 
from bs4 import BeautifulSoup
 
# LIMIT = 10 # Valid values: 10, 20, 30, 40, 50, and 100

USER_AGENTS = [
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36',
]
class indiamart:
 
    def make_request(searchTerm,location):
        assert isinstance(searchTerm, str), 'Search term must be a string'
        escaped_search_term = searchTerm.replace(' ', '+')
        escaped_search_term+='+agriculture'
        limit = 3
        google_url = 'https://dir.indiamart.com/search.mp?ss={}&no_sugg=1&cq={}&cq_src=city-search'.format(escaped_search_term, limit)
        response = requests.get(google_url, headers={'User-Agent': random.choice(USER_AGENTS)})
        response.raise_for_status() 
        print(google_url)
        # print(response.content)
 
        return response.content

    def parse_content(html):
        soup = BeautifulSoup(html,'html.parser')
        results = []
        # items = soup.find_all("div",class_="")[ 'sh-dgr__gr-auto','sh-pr__grid-result']
        items = soup.findAll("ul", {'class':'mListDtl sid_df sid_fdc'})
        for item in items:  
            image = item.find('img').get('src')
            name = item.find('span',{'data-click':'^Prod0Name'}).a
            if not name:
                pass
            else:
                name = name.text
            companyname = item.find('h4',{'data-click':'^CompanyName'}).a.text
            price = item.find('li',{'class':'mListPrc'}).findAll('span')[1].span
            if not price:
                pass
            else:
                price=price.text
            unit = item.find('span',{'class':'quan'})
            if not unit:
                pass
            else:
                unit = unit.text
            link = item.find('span',{'data-click':'^Prod0Name'}).a
            if not link:
                pass
            else:
                link = link.get('href') 
            address = item.find('span',{'class':'mDib mToTxt'}).text 
            results.append({'name': name, 'price': price, 'companyname': companyname,'image': image,'link':link, 'unit':unit,'address':address})
        # print({'name': name, 'price': price, 'seller': seller, 'reviews': reviews,'stars': stars})
        print(results)
        return results




