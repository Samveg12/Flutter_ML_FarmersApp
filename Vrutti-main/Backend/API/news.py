import requests
import sys
import csv
import random 
from bs4 import BeautifulSoup
 
# LIMIT = 10 # Valid values: 10, 20, 30, 40, 50, and 100
USER_AGENTS = [
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36',
]

class news:
    def make_request():
        google_url = 'https://www.google.com/search?rlz=1C1CHBF_enIN921IN921&ei=8sEnYI2HKMmf9QOf47n4AQ&q=agriculture+news+inshorts&oq=agriculture+news+inshorts&gs_lcp=Cgdnd3Mtd2l6EAM6BAgAEA1Q26QIWIHaCGDm3AhoBnAAeACAAd8BiAHAF5IBBjAuMTYuMZgBAKABAaoBB2d3cy13aXrAAQE&sclient=gws-wiz&ved=0ahUKEwiNyKO56ubuAhXJT30KHZ9xDh8Q4dUDCA0&uact=5'
        response = requests.get(google_url, headers={'User-Agent': random.choice(USER_AGENTS)})
        response.raise_for_status() 
        print(google_url)
    # print(response.content)S
        return response.content

    def parse_content(html):
        soup = BeautifulSoup(html,'html.parser')
        results = []
        count = 1
        # items = soup.find_all("div",class_="")[ 'sh-dgr__gr-auto','sh-pr__grid-result']
        items = soup.findAll("div", {'class':'g'})
        for item in items:  
            if count > 3 :
                break
            count = count + 1
            link = item.div.div.a.get('href')
            title = item.div.div.a.h3.text
            response = requests.get(link, headers={'User-Agent': random.choice(USER_AGENTS)})
            response.raise_for_status() 
            soup = BeautifulSoup(response.content,'html.parser')
            author = soup.find('span', {'class':'author'}).text
            date = soup.find('span', {'class':'date'}).text
            time = soup.find('span', {'class':'time'}).text
            content = soup.find('div', {'itemprop':'articleBody'}).text
            results.append({'title':title, 'content':content, 'author':author, 'date':date, 'time':time})
        print(results[0])
        return results
 





