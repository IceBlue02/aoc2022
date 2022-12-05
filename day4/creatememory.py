
with open('data.txt') as file:
    print('DCB ' + ', '.join([str(ord(c)) for c in list(file.read() + '\0')]))
