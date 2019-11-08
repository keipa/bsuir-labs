import numpy as np
from bs4 import BeautifulSoup
import re
from nltk.stem import SnowballStemmer
from nltk.tokenize import sent_tokenize, word_tokenize
# import nltk #1.11.0
# nltk.download('punkt')
class MailPreprocessor:

    def low_registry(self, message):
        return message.lower()

    def dollar(self, message):
        return message.replace("$", "dollar")

    def html_tags(self, message):
        return BeautifulSoup(message, "lxml").text

    def url(self, message):
        return re.sub(r'^https?:\/\/.*[\r\n]*', 'httpaddr', message, flags=re.MULTILINE)

    def email(self, message):
        return re.sub(r'[\w\.-]+@[\w\.-]+', 'emailaddr', message, flags=re.MULTILINE)

    def numbers(self, message):
        return re.sub(r'\d+', ' number ', message, flags=re.MULTILINE)

    def stem(self, sentence):
        lancaster = SnowballStemmer(language="english")
        token_words = word_tokenize(sentence)
        stem_sentence = []
        for word in token_words:
            stem_sentence.append(lancaster.stem(word))
            stem_sentence.append(" ")
        return "".join(stem_sentence)

    def non_letters(self, message):
        return re.sub(r'([^\s\w]|_)+', '', message, flags=re.MULTILINE)


    filter_order = [low_registry, dollar, html_tags, url, email, numbers, non_letters, stem]

    def filter(self, message):
        for method in self.filter_order:
            message = method(self, message)
        return message


spam_file = open("data/spamSample1.txt", "r")
text = spam_file.read()

# print(text)

processor = MailPreprocessor()


clean_text = processor.filter(text)


def one_hot_convert(message):
    message_words = message.split()
    message_words.sort()
    vocab_file = open("data/vocab.txt", "r")
    vocab = vocab_file.readlines()
    # one_hot = [int(record.split()[1] in message) for record in vocab]
    one_hot = []
    for record in vocab:
        word = record.split()[1]
        one_hot.append(int(word in message_words))
        pass
    return np.array(one_hot)

print(one_hot_convert(clean_text))