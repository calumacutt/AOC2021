from itertools import accumulate

f = open("input.txt", "r")
count = [0] * 12
total_lines = 0
for line in f.readlines():
    for bit in range(12):
        count[bit] += int(line[bit])
    total_lines += 1

gamma = [0] * 12

for bit in range(12):
    if count[bit] * 2 > total_lines:
        gamma[bit] = 1
    else:
        gamma[bit] = 0

print(gamma)

epsilon = list(map(lambda x: 1 if x == 0 else 0, gamma))

print(epsilon)

dec_epsilon = int(list(accumulate(epsilon, lambda x, y: str(x) + str(y)))[-1], 2)
dec_gamma = int(list(accumulate(gamma, lambda x, y: str(x) + str(y)))[-1], 2)

print(dec_epsilon * dec_gamma)