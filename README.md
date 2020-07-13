L2 Challenges monitoring-test
L2 Challenges monitoring-test

=================================================

Question-One :

Write a program (in any programming language) that prints random number from 1 to 100.

=================================================

Question-Two:

Please provide a shell-script to list all files in /var/www/html (include subdirectories) with .php extension, find them, then copy them to /opt/html.

=================================================

Question-Three:

In this repository, please find the sample-1.log. The challenge is to parse the log using Grok Parser, and please generate logstash configuration.

Output should be :

Date : 2017-08-01 01:11:33,999/</br>
ServiceId : 9999</br>
ServiceName: dompet</br>
channelSessionId : 10100000000123456789</br>
remark : BillPayment</br>
OriginatorConversationID : ASSTR0123123456456789789</br>
Msisdn : 6281xxxxxxxxx</br>
CommandId : PreValConfirmation

=================================================

Question-Four:

In this repository, please find the sample-2.log. The challenge is to parse the log using Grok Parser, and please generate logstash configuration.

The Output should be:

Data.uuid: 59bd2e00-465b-11ea-987a-b74a8d671e08</br>
Data.rt: 999</br>
Data.port: 65530</br>
Data.ip: 123.123.123.123</br>
Data.appli: abcd</br>
Data.versi: v99</br>
Data.path: /xx/yy/xyz/aha</br>

=================================================

Good Luck!!!


++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Answer

Question-One :
import random
print(random.randint(1, 100))

===================================================================
Question-Two:
#/bin/sh
find /var/www/html/ -type f -iname "*.php" -exec cp {} /opt/html/ \;

====================================================================
Question-Three:
input {
  file {
    path => "sample-1.log"
    start_position => "beginning"
  }
}

filter {
   grok {
        match => { "message" => "%{TIMESTAMP_ISO8601:date}\|%{WORD:serviceid}\{\"channelSessionId\":\"%{WORD:channelSessionId}\",\"remark\":\"%{WORD:remark}\",\"OriginatorConversationID\":\"%{WORD:OriginatorConversationID}\",\"Msisdn\":\"%{WORD:Msisdn}\",\"CommandId\":\"%{WORD:CommandId}" }
   }
}

output {
  elasticsearch { hosts => ["localhost:9200"] }
  stdout { codec => rubydebug }
}

====================================================================
Question-Four:
input {
  file {
    path => "sample-2.log"
    start_position => "beginning"
  }
}

filter {
   grok {
        match => { "message" => "{%{QS}:\"%{UUID:Data.UUID}\",%{QS}:%{WORD:Data.rt},%{QS}:\"%{WORD:Data.port}\",%{QS}:\"%{IP:Data.ip}\",%{QS}:\"%{WORD:Data.appli}\",%{QS}:\"%{WORD:Data.versi}\",%{QS}:\"%{UNIXPATH:Data.path}" }

   }
}

output {
  elasticsearch { hosts => ["localhost:9200"] }
  stdout { codec => rubydebug }
}

Thanks
Yaomal
