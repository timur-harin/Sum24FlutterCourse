import csv
import json
import matplotlib.pyplot as plt
from collections import Counter
from textblob import TextBlob
from wordcloud import WordCloud

data = json.load(open('feedback/data/sum24_final_after_project.json'))
responses = [response[0][1] for response in data]

response_count = Counter(responses)

plt.figure(figsize=(10, 6))
plt.bar(response_count.keys(), response_count.values())
plt.ylabel('Number of Responses')
plt.title('Overall Impressions After the Course')
plt.xticks(rotation=45, ha="right")
plt.tight_layout()

plt.savefig('feedback/figures/sum24/overall_impressions.png')

responses = [response[1][1] for response in data]

response_count = Counter(responses)

plt.figure(figsize=(10, 6))
plt.bar(response_count.keys(), response_count.values())
plt.ylabel('Number of Responses')
plt.title('Now I...')
plt.xticks(rotation=45, ha="right")
plt.tight_layout()

plt.savefig('feedback/figures/sum24/now_i.png')


responses = [response[2][1] for response in data]

response_count = Counter(responses)

plt.figure(figsize=(10, 6))
plt.bar(response_count.keys(), response_count.values())
plt.ylabel('Number of Responses')
plt.title('How do you feel after talking with classmates from other electives?')
plt.xticks(rotation=45, ha="right")
plt.tight_layout()

plt.savefig('feedback/figures/sum24/how_do_you_feel.png')

responses = [response[3][1] for response in data]

response_count = Counter(responses)

plt.figure(figsize=(10, 6))
plt.bar(response_count.keys(), response_count.values())
plt.ylabel('Number of Responses')
plt.title('This elective is compared to other courses ...')
plt.xticks(rotation=45, ha="right")
plt.tight_layout()

plt.savefig('feedback/figures/sum24/this_elective.png')

responses = [response[4][1] for response in data]

response_count = Counter(responses)

plt.figure(figsize=(10, 6))
plt.bar(response_count.keys(), response_count.values())
plt.ylabel('Number of Responses')
plt.title('If I had known in advance how this elective would go, then I would')
plt.xticks(rotation=45, ha="right")
plt.tight_layout()

plt.savefig('feedback/figures/sum24/if_i_had_known.png')

responses = [response[5][1] for response in data]

response_count = Counter(responses)

plt.figure(figsize=(10, 6))
plt.bar(response_count.keys(), response_count.values())
plt.title('At the end of the course , I ...')
plt.xticks(rotation=45, ha="right")
plt.tight_layout()

plt.savefig('feedback/figures/sum24/at_the_end.png')


responses = [response[6][1]
             for response in data]

plt.figure(figsize=(10, len(responses) / 2))
plt.axis([0, 1, 0, len(responses)])
plt.title("I haven't seen this in other courses, but I liked it in this one")
plt.yticks([])
plt.xticks([])
plt.box(False)

for i, response in enumerate(responses, start=1):
    plt.text(0.01, i, response, ha='left', va='center',
             wrap=True, fontsize=8)

plt.tight_layout()

plt.savefig('feedback/figures/sum24/no_in_others_but_liked_in_this.png')

responses = [response[7][1]
             for response in data]

plt.figure(figsize=(10, len(responses) / 2))
plt.axis([0, 1, 0, len(responses)])
plt.title(
    "I haven't seen this in other courses, and it's good that it wasn't here either")
plt.yticks([])
plt.xticks([])
plt.box(False)

for i, response in enumerate(responses, start=1):
    plt.text(0.01, i, response, ha='left', va='center', wrap=True, fontsize=8)

plt.tight_layout()

plt.savefig('feedback/figures/sum24/no_in_others_and_good.png')

responses = [response[8][1]
             for response in data]

plt.figure(figsize=(10, len(responses) / 2))
plt.axis([0, 1, 0, len(responses)])
plt.title(
    "I've seen it in other courses, and I've missed it in this one")
plt.yticks([])
plt.xticks([])
plt.box(False)

for i, response in enumerate(responses, start=1):
    plt.text(0.01, i, response, ha='left', va='center', wrap=True, fontsize=8)

plt.tight_layout()

plt.savefig('feedback/figures/sum24/seen_in_others_and_missed_in_this.png')


responses = [response[9][1]
             for response in data]

plt.figure(figsize=(10, len(responses) / 2))
plt.axis([0, 1, 0, len(responses)])
plt.title(
    "I've seen it in other courses, and it's a good thing he wasn't here")
plt.yticks([])
plt.xticks([])
plt.box(False)

for i, response in enumerate(responses, start=1):
    plt.text(0.01, i, response, ha='left', va='center', wrap=True, fontsize=8)

plt.tight_layout()

plt.savefig('feedback/figures/sum24/seen_in_others_and_good_not_have_here.png')


responses = [response[10][1]
             for response in data]

plt.figure(figsize=(10, len(responses) / 2))
plt.axis([0, 1, 0, len(responses)])
plt.title(
    "I've learned...")
plt.yticks([])
plt.xticks([])
plt.box(False)

for i, response in enumerate(responses, start=1):
    plt.text(0.01, i, response, ha='left', va='center', wrap=True, fontsize=8)

plt.tight_layout()

plt.savefig('feedback/figures/sum24/learned.png')

responses = [response[11][1]
             for response in data]

plt.figure(figsize=(10, len(responses) / 2))
plt.axis([0, 1, 0, len(responses)])
plt.title(
    "It seemed useless to me...")

plt.yticks([])
plt.xticks([])
plt.box(False)

for i, response in enumerate(responses, start=1):
    plt.text(0.01, i, response, ha='left', va='center', wrap=True, fontsize=8)

plt.tight_layout()

plt.savefig('feedback/figures/sum24/useless.png')


responses = [response[12][1]
             for response in data]

plt.figure(figsize=(10, len(responses) / 2))
plt.axis([0, 1, 0, len(responses)])
plt.title(
    "This course can be improved by ...")

plt.yticks([])
plt.xticks([])
plt.box(False)

for i, response in enumerate(responses, start=1):
    plt.text(0.01, i, response, ha='left', va='center', wrap=True, fontsize=8)

plt.tight_layout()

plt.savefig('feedback/figures/sum24/improve_by.png')


responses = [response[13][1] for response in data]

response_count = Counter(responses)

plt.figure(figsize=(10, 6))
plt.bar(response_count.keys(), response_count.values())
plt.ylabel('Number of Responses')
plt.title('I think that Timur...')
plt.xticks(rotation=45, ha="right")
plt.tight_layout()

plt.savefig('feedback/figures/sum24/timur_flutter_skills.png')

responses = [response[14][1] for response in data]

response_count = Counter(responses)

plt.figure(figsize=(10, 6))
plt.bar(response_count.keys(), response_count.values())
plt.ylabel('Number of Responses')
plt.title("Timur's English level")
plt.xticks(rotation=45, ha="right")
plt.tight_layout()

plt.savefig('feedback/figures/sum24/timur_english_level.png')

responses = [response[15][1] for response in data]

response_count = Counter(responses)

plt.figure(figsize=(10, 6))
plt.bar(response_count.keys(), response_count.values())
plt.ylabel('Number of Responses')
plt.title("Timur's approach compared to other courses ...")
plt.xticks(rotation=45, ha="right")
plt.tight_layout()

plt.savefig('feedback/figures/sum24/timur_approach.png')


responses = [response[16][1] for response in data]

plt.figure(figsize=(10, len(responses) / 2))
plt.axis([0, 1, 0, len(responses)])
plt.title(
    "I want to do it after this course...")
plt.yticks([])
plt.xticks([])
plt.box(False)

for i, response in enumerate(responses, start=1):
    plt.text(0.01, i, response, ha='left', va='center', wrap=True, fontsize=8)

plt.tight_layout()

plt.savefig('feedback/figures/sum24/do_after.png')

responses = [response[17][1] for response in data]

plt.figure(figsize=(10, len(responses) / 2))
plt.axis([0, 1, 0, len(responses)])
plt.title(
    "I promise based on the results of this course over the summer, not necessarily about studying")
plt.yticks([])
plt.xticks([])
plt.box(False)

for i, response in enumerate(responses, start=1):
    plt.text(0.01, i, response, ha='left', va='center', wrap=True, fontsize=8)

plt.tight_layout()

plt.savefig('feedback/figures/sum24/promise.png')

responses = [response[18][1] for response in data]

plt.figure(figsize=(10, len(responses) / 2))
plt.axis([0, 1, 0, len(responses)])
plt.title(
    "I wish + to whom I wish it")
plt.yticks([])
plt.xticks([])
plt.box(False)


for i, response in enumerate(responses, start=1):
    plt.text(0.01, i, response, ha='left', va='center', wrap=True, fontsize=8)

plt.tight_layout()

plt.savefig('feedback/figures/sum24/wish.png')


with open('feedback/data/[Sum24] FCPA Grades.csv') as file:
    reader = csv.reader(file)
    grades = [row[0] for row in reader]

grade_counts = {'A': grades.count('A'),
                'B': grades.count('B'),
                'C': grades.count('C'),
                'D': grades.count('D'),
                'F': grades.count('F')
                }

plt.figure(figsize=(10, 6))
labels = []
sizes = []
for label, count in grade_counts.items():
    if count != 0:
        labels.append(label)
        sizes.append(count)

plt.pie(sizes, labels=labels, autopct='%1.1f%%')
plt.axis('equal')
plt.tight_layout()

plt.savefig('feedback/figures/sum24/grades.png')
