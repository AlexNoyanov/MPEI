# -*- coding: utf-8 -*-
import time
import vk_api
vk = vk_api.VkApi(login = '79161031424', password = 'vaultboy5519')
#vk_api.VkApi(token = 'a02d...e83fd') #Авторизоваться как сообщество
vk.auth()
values = {'out': 0,'count': 100,'time_offset': 60}

def write_msg(user_id, s):
    vk.method('messages.send', {'user_id':user_id,'message':s})

values = {'out': 0,'count': 100,'time_offset': 60}
vk.method('messages.get', values)

flag = 0
helloWords = ['привет','Привет']
byeWords = ['пока', 'Пока'];

while True:
    response = vk.method('messages.get', values)
    if response['items']:
        values['last_message_id'] = response['items'][0]['id']
    for item in response['items']:
        text = item['body']
            if (text in helloWrods) :
                 write_msg(item[u'user_id'],u'привет')
                     
       # if text == 'Hello':
        #    write_msg(item[u'user_id'], item['Hello hruk!'])
        #if text == u'bye':
         #   write_msg(item[u'user_id'], item['Goodbye!'])
         if flag == 0:
            #write_msg(item[u'user_id'],u'Привет, Хабр!')
            #write_msg(item[u'user_id'], item['body'])
           
            write_msg(item[u'user_id'],u'Как дела?')
            flag = 1
