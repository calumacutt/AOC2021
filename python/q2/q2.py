f = open("input.txt", "r")
depth = 0
dist = 0
for line in f.readlines():
    if line[0:7] == "forward":
        dist += int(line[8:])
    elif line[0:4] == "down":
        depth += int(line[5:])
    elif line[0:2] == "up":
        depth -= int(line[3:])

print(depth * dist)

f = open("input.txt", "r")
depth = 0
dist = 0
aim = 0
for line in f.readlines():
    if line[0:7] == "forward":
        dist += int(line[8:])
        depth += aim * int(line[8:])
    elif line[0:4] == "down":
        aim += int(line[5:])
    elif line[0:2] == "up":
        aim -= int(line[3:])

print(depth * dist)