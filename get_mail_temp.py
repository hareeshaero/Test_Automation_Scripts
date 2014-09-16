import imaplib
import email

conn= imaplib.IMAP4_SSL('imap.googlemail.com')
conn.login('hareesh@aerospike.com', 'H@r335h9u')

conn.select()
typ, data = conn.search(None, 'SUBJECT', "Please Build Aerospike Server 3.3.19")

for num in data[0].split():
    typ, data = conn.fetch(num, '(RFC822)')
    #print('Message %s\n%s\n' % (num, data[0][1]))
    email = email.message_from_string(data[0][1])

    for part in email.walk():
        if part.get_content_type() == 'text/plain':
            message = part.get_payload(decode=True)
            temp = message.replace('^M', '')
            print temp

conn.close()
conn.logout()
