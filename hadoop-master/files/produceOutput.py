all_tokens = 0
bigrams = []
with open("output.txt") as file:
    for line in file:
        token, count = line.strip().split("\t")
        count = int(count)
        all_tokens += count
        bigrams.append((token,count))

print "\n"
print "Total number of bigrams:", all_tokens
print "\n"
bigrams.sort(key = lambda x: x[1], reverse = True)

print "Most common bigram:", bigrams[0]
print "\n"

print "Top 10 bigrams:"
for i in range(10):
    print bigrams[i]
print "\n"

i = 0
counter = 0
target = all_tokens / 10
for bi in bigrams:
    i += 1
    counter += bi[1]
    if counter > target:
        break
print "No. of bigrams required to add up to 10% of all bigrams:", i
print "\n"
