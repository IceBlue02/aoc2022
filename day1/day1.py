

def part1():
    data = []
    with open('data.txt') as infile:
        data = infile.read().strip().split('\n\n')

    return max([sum([int(y) for y in elflist.split('\n')]) for elflist in data])

def part2():
    data = []
    with open('data.txt') as infile:
        data = infile.read().strip().split('\n\n')

    return sum(sorted([sum([int(y) for y in elflist.split('\n')]) for elflist in data], reverse=True)[:3])


print(part1())
print(part2())
