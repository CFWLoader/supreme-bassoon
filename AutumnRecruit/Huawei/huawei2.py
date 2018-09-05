def contains(str1, str2):

    chDict = dict()

    for ch in str1:
        if ch in chDict:
            chDict[ch] = chDict[ch] + 1
        else:
            chDict[ch] = 1

    for ch in str2:
        if not ch in chDict:
            return "false"

    return "true"

str1 = input()
str2 = input()

print(contains(str1, str2))