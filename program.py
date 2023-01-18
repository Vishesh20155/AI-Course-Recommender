from pyswip import Prolog
from nltk.tokenize import sent_tokenize
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from nltk.stem import PorterStemmer


prolog = Prolog()
prolog.consult("A1_ElectivesAdvisory.pl")

text = input("Enter details of your branch, other branches of interest, semester type and the courses done:\n")
# text = "I am from CSE branch. I am looking for couses of winter semester. I have done courses m1, m2, ip, dm, cn, os, pr. I am also interestted in courses from CSB and ECE"
# text = "I am from CSE branch. I am looking for couses of monsoon semester. I have done courses m1, m2, ip, dm, cn, os, pr. I am also interestted in courses from CSSS and CSD"

# word 'also' is important

text_lower = text.lower()
# print(text_lower)

# Sentence Tokeziation being used:
sentences = sent_tokenize(text_lower)
# print(sentences)

# print()

# Removing stop words
sw = set(stopwords.words('english'))

# Stemming:

no_sent = len(sentences)

words = []

for i in range(no_sent):
  words.append(word_tokenize(sentences[i]))


# print(words)

ps=PorterStemmer()

stemmed = []
for s in words:
  x=[]
  for w in s:
    y = ps.stem(w)
    if y not in sw:
      x.append(ps.stem(w))
  stemmed.append(x)

# print(stemmed)

branches = set({})
semester_type = 'monsoon'

courses = {'fcs', 'ns', 'ac', 'ai', 'ml', 'nlp', 'rl', 'cmp', 'ca', 'aag', 'mad', 'mlba', 'bip', 'chi', 'fomb', 'gmt', 'ff', 'tfw', 'etb', 'ndm', 'cmm', 'ecomm', 'ek', 'tnt', 'cmpa', 'sc', 'iag', 'davp', 'df', 'cmor', 'bdmh', 'acb', 'dsg', 'ma', 'its', 'ast', 'sp', 'lm', 'ciips', 'ef', 'athcc', 'dis', 'gdd', 'si', 'coo', 'lo', 'ifa', 'mlw', 'dl', 'mc', 'fpp', 'gpu', 'wn', 'pn', 'tmc', 'tacs', 'nssii', 'sml', 'rs', 'pdcs', 'vdf', 'aeld', 'dpm', 'dsp', 'tgi', 'qmd', 'icf'}

for s in stemmed:
  if ('also' in s) or ('branch' in s):
    if 'cse' in s:
      branches.add('cse')
    if 'csam' in s:
      branches.add('csam')
    if 'csd' in s:
      branches.add('csd')
    if 'ece' in s:
      branches.add('ece')
    if 'csb' in s:
      branches.add('csb')
    if 'csss' in s:
      branches.add('csss')

  if 'winter' in s:
    semester_type='winter'

  if 'done' in s:
    for j in s:
      if (len(j)>1):
        if j=='sn':
          prolog.assertz("courseDone({})".format('sns'))
        else:
          prolog.assertz("courseDone({})".format(j))


def show_monsoon(branches):
  print('\nList of interests you can pursue next semester:')
  if 'cse' in branches:
    print('Cyber Security')
    print('Core Computer Science')
    print('Algorithms')
    print('ML')

  if 'csb' in branches:
    print('Theoretical Bio')
    print('Bio-Algorithms')

  if 'csss' in branches:
    print('Economics')
    print('Sociology')
    print('Psychology')
    print('Entrepreneurship')

  if 'ece' in branches:
    print('Hardware ECE')
    print('Software ECE')

  print()
  text2 = input("Enter your interests from the above list:\n")
  text2 = text2.lower()
  text2_words = word_tokenize(text2)

  if 'csam' in branches:
    list(prolog.query("getCourseSuggestion(csam, monsoon)."))

  if 'csd' in branches:
    list(prolog.query("getCourseSuggestion(csd, monsoon)."))

  if 'hardware' in text2_words:
    list(prolog.query("hardWareM(y)."))
    
  if 'software' in text2_words:
    list(prolog.query("softWareM(y)."))

  if 'algorithms' in text2_words:
    list(prolog.query("algoCourse(y)."))

  if 'security' in text2_words:
    list(prolog.query("securityCourses(y)."))

  if 'core' in text2_words:
    list(prolog.query("advCSCourse(y)."))

  if 'ml' in text2_words:
    list(prolog.query("mlCourses(y)."))

  if 'bio-algorithms' in text2_words:
    list(prolog.query("bioPrac(y)."))

  if 'theoretical' in text2_words:
    list(prolog.query("bioTheory(y)."))

  if 'economics' in text2_words:
    list(prolog.query("ecoCourses(y)."))

  if 'sociology' in text2_words:
    list(prolog.query("socCourse(y)."))

  if 'psychology' in text2_words:
    list(prolog.query("psyCourses(y)."))

  if 'entrepreneurship' in text2_words:
    list(prolog.query("entCourses(y)."))


  list(prolog.query("func_for_nlp()."))


def show_winter(branches):
  print('\nList of interests you can pursue next semester:')
  if 'cse' in branches:
    print('Cyber Security')
    print('Networks')
    print('General CSE courses')
    print('ML')

  if 'csb' in branches:
    print('Biology related Data Science')
    print('Bio-Algorithms')

  if 'csss' in branches:
    print('Economics')
    print('Sociology')
    print('Psychology')
    print('Entrepreneurship')

  if 'ece' in branches:
    print('Communication ECE')
    print('Electronics Design')

  print()
  text2 = input("Enter your interests from the above list:\n")
  text2 = text2.lower()
  text2_words = word_tokenize(text2)

  if 'csam' in branches:
    list(prolog.query("getCourseSuggestion(csam, winter)."))

  if 'csd' in branches:
    list(prolog.query("getCourseSuggestion(csd, winter)."))

  if 'communication' in text2_words:
    list(prolog.query("commW(y)."))
    
  if 'design' in text2_words:
    list(prolog.query("elecDesW(y)."))

  if 'general' in text2_words:
    list(prolog.query("otherCseW(y)."))

  if 'security' in text2_words:
    list(prolog.query("securityCoursesW(y)."))

  if 'networks' in text2_words:
    list(prolog.query("networkCoursesW(y)."))

  if 'ml' in text2_words:
    list(prolog.query("mlCoursesW(y)."))

  if 'bio-algorithms' in text2_words:
    list(prolog.query("bioAlgo(y)."))

  if 'data' in text2_words:
    list(prolog.query("bioDataCourses(y)."))

  if 'economics' in text2_words:
    list(prolog.query("ecoCoursesW(y)."))

  if 'sociology' in text2_words:
    list(prolog.query("socCourseW(y)."))

  if 'psychology' in text2_words:
    list(prolog.query("psyCoursesW(y)."))

  if 'entrepreneurship' in text2_words:
    list(prolog.query("entCoursesW(y)."))


  list(prolog.query("func_for_nlp()."))




if semester_type=='monsoon':
    show_monsoon(branches)
else:
    show_winter(branches)

print("Metadata")
print(branches)
print(semester_type)