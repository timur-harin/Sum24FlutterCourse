import csv
import json
import matplotlib.pyplot as plt
from collections import Counter
from textblob import TextBlob
from wordcloud import WordCloud


base_dir = 'feedback/figures/sum24/'

data = json.load(open('feedback/data/sum24_final_after_project.json'))


def plot_bar_chart(data, title, filename, xlabel='Number of Responses'):
    response_count = Counter(data)
    plt.figure(figsize=(10, 6))
    bars = plt.bar(response_count.keys(), response_count.values())
    plt.ylabel(xlabel)
    plt.title(title)
    plt.xticks(rotation=45, ha="right")

    total = sum(response_count.values())
    for bar in bars:
        height = bar.get_height()
        percentage = f'{100 * height/total:.1f}%'
        plt.text(bar.get_x() + bar.get_width() / 2, height,
                 percentage, ha='center', va='bottom')

    plt.tight_layout()
    plt.savefig(base_dir + filename)


def clear_text_data(data):
    cleared_data = []
    for d in data:
        if len(d) > 3:
            cleared_data.append(d)
    return cleared_data


def plot_text_responses(data, title, filename):
    new_data = clear_text_data(data)
    plt.figure(figsize=(10, len(new_data) * 0.7))
    plt.axis([-0.1, 1.1, 0, len(new_data)+2])  
    plt.title(title, pad=20)
    plt.yticks([])
    plt.xticks([])
    plt.box(False)
    for i, response in enumerate(new_data, start=1):
        plt.text(0.01, i + 0.5, response, ha='left', 
                 va='center', wrap=True, fontsize=8)
    plt.tight_layout()
    plt.savefig(base_dir + filename)


plot_bar_chart([response[0][1] for response in data],
               'Overall Impressions After the Course', 'overall_impressions.png')


plot_bar_chart([response[1][1] for response in data],
               'Now I...', 'now_i.png')


plot_bar_chart([response[2][1] for response in data],
               'How do you feel after talking with classmates from other electives?',
               'how_do_you_feel.png')


plot_bar_chart([response[3][1] for response in data],
               'This elective is compared to other courses ...',
               'this_elective.png')


plot_bar_chart([response[4][1] for response in data],
               'If I had known in advance how this elective would go, then I would',
               'if_i_had_known_in_advance.png')


plot_bar_chart([response[5][1] for response in data],
               'At the end of the course , I ...',
               'at_the_end.png')


plot_text_responses([response[6][1] for response in data],
                    "I haven't seen this in other courses, but I liked it in this one", 'no_in_others_but_liked_in_this.png')


plot_text_responses([response[7][1] for response in data],
                    "I haven't seen this in other courses, and it's good that it wasn't here either", 'no_in_others_and_good.png')


plot_text_responses([response[8][1] for response in data],
                    "I've seen it in other courses, and I've missed it in this one", 'seen_in_others_and_missed_in_this.png')


plot_text_responses([response[9][1] for response in data],
                    "I've seen it in other courses, and it's a good thing he wasn't here", 'seen_in_others_and_good_not_have_here.png')


plot_text_responses([response[10][1] for response in data],
                    "I've learned...", 'learned.png')


plot_text_responses([response[11][1] for response in data],
                    "It seemed useless to me...", 'useless.png')

plot_text_responses([response[12][1] for response in data],
                    "This course can be improved by ...", 'improve_by.png')

plot_bar_chart([response[13][1] for response in data],
               "I think that Timur...", 'timur_flutter_skills.png')


plot_bar_chart([response[14][1] for response in data],
               "Timur's English level", 'timur_english_level.png')


plot_bar_chart([response[15][1] for response in data],
               "Timur's approach compared to other courses ...", 'timur_approach.png')


plot_text_responses([response[16][1] for response in data],
                    "I want to do it after this course...", 'want_to_do_after.png')


plot_text_responses([response[17][1] for response in data],
                    "I promise based on the results of this course over the summer, not necessarily about studying", 'promise.png')


plot_text_responses([response[18][1] for response in data],
                    "I wish + to whom I wish it", 'wish.png')


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
