# ENTRYPOINT और CMD में अन्तर

नीचे बहुत ही सरल भाषा और उदाहरणों के साथ समझाया गया है कि Dockerfile में ENTRYPOINT और CMD का रोल क्या होता है और दोनों में असल फर्क क्या है।

---

## ENTRYPOINT क्या है?

ENTRYPOINT Dockerfile में वो कमांड या executable होता है जिसे कंटेनर स्टार्ट होते ही **हमेशा** चलाना होता है।  
ENTRYPOINT को बदलने के लिए `docker run` में `--entrypoint` फ्लैग का यूज़ करना पड़ता है।

उदाहरण:
```dockerfile
FROM ubuntu:latest

WORKDIR /app
COPY hello.sh .

# ENTRYPOINT सेट कर रहा हूँ
ENTRYPOINT ["bash", "hello.sh"]
```
यहाँ कंटेनर रन होते ही `bash hello.sh` कट्टरनियमानुसार चलेगा।

---

## CMD क्या है?

CMD Dockerfile में डिफ़ॉल्ट आर्ग्यूमेंट्स या कमांड बताता है।  
अगर `docker run <image>` के बाद कोई आर्ग्यूमेंट न दिया जाए, तभी CMD चालू होता है।  
CMD को `docker run <image> <other>` से आसानी से ओवरराइड किया जा सकता है।

उदाहरण:
```dockerfile
FROM ubuntu:latest

WORKDIR /app
COPY greet.sh .

# CMD सेट कर रहा हूँ
CMD ["bash", "greet.sh", "World"]
```
- `docker run myimage` → चलेगा `bash greet.sh World`  
- `docker run myimage Alice` → अब CMD की जगह `["Alice"]` आर्ग्यूमेंट लगेगा, यानी `bash greet.sh Alice`

---

## ENTRYPOINT और CMD का तालमेल

जब Dockerfile में दोनों दिए हों, तो ENTRYPOINT मुख्य कमांड होता है और CMD उसके आर्ग्यूमेंट्स होते हैं।  
कंटेनर स्टार्ट होते समय रन होगा:
```
ENTRYPOINT + CMD
```

कोड उदाहरण:
```dockerfile
FROM python:3.9-slim

WORKDIR /app
COPY app.py .

ENTRYPOINT ["python", "app.py"]
CMD ["--help"]
```
- `docker run myimage` → `python app.py --help`  
- `docker run myimage --version` → `python app.py --version`

---

## मुख्य फ़र्क

| पहलू               | ENTRYPOINT                                          | CMD                                                |
| ------------------ | ---------------------------------------------------- | -------------------------------------------------- |
| मकसद              | कंटेनर का मुख्य executable सेट करना                   | डिफ़ॉल्ट कमांड या आर्ग्यूमेंट्स देना               |
| ओवरराइड करना      | `--entrypoint` का इस्तेमाल करके बदलना पड़ता है        | `docker run <image> <new-args>` से बदला जा सकता है |
| स्टार्टअप बर्ताव    | हर बार चलता है                                        | तभी चलता है जब रन कमांड में कोई नया आर्ग्यूमेंट न दिया हो |
| संयोजन (Compose)  | CMD को आर्ग्यूमेंट्स के रूप में जोड़ता है               | ENTRYPOINT के बाद आर्ग्यूमेंट्स के रूप में जुड़ता है |

---

## कब क्या यूज़ करें?

- अगर आपका कंटेनर एक स्पेसिफिक एप्लिकेशन (जैसे Python स्क्रिप्ट) हमेशा ही चलाएगा, तो ENTRYPOINT में वह एप्लीकेशन डालें।  
- CMD में वही वैल्यूज डालें जिन्हें आप डिफ़ॉल्ट तौर पर चाहते हैं, जैसे पोर्ट, मोड या प्रीसेट आर्ग्यूमेंट्स।  
- यूज़र्स को अगर सिर्फ आर्ग्यूमेंट्स बदलने का ऑप्शन देना हो तो CMD का सहारा लें।  
- कंटेनर को पूरी तरह से लॉकडाउन करना हो कि कमांड बदले न, तो केवल ENTRYPOINT यूज़ करें और CMD छोड़ दें या खाली रखें।

---

इस तरह ENTRYPOINT कंटेनर का “मेजर कमांड” होता है और CMD उसके “डिफ़ॉल्ट आर्ग्यूमेंट्स” होते हैं। दोनों मिलकर कंटेनर को लचीला और नियंत्रित बनाते हैं।
