from more_itertools import windowed

f = open("input.txt", "r")
last_depth = 0
curr_depth = 0
count = 0
for line in f.readlines():
    last_depth = curr_depth
    curr_depth = int(line)
    if curr_depth - last_depth > 0:
        count += 1

print(count-1)

f = open("input.txt", "r")
windows_sum = map(sum, list(windowed(map(int, f), 3)))
result = sum(map(lambda x: 1 if x[1] - x[0] > 0 else 0, windowed(windows_sum, 2)))
print(result)