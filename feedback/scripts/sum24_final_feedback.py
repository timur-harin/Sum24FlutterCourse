import json
import matplotlib.pyplot as plt
from collections import Counter

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
plt.ylabel('Number of Responses')
plt.title('At the end of the course , I ...')
plt.xticks(rotation=45, ha="right")
plt.tight_layout()

plt.savefig('feedback/figures/sum24/at_the_end.png')

