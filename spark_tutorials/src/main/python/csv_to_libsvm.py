import os
# import read_csv

script_dir = os.path.dirname(os.path.realpath(__file__))

with open(os.path.join(script_dir, "..", "resources", "kr-vs-kp.csv")) as raw_file:
    peekline = raw_file.readline()
    attrslen = len(peekline.split(','))
    writebuffers = []
    tranfeatsmap = []
    cnt = 0
    for i in range(0, attrslen):
        tranfeatsmap.append(dict())
    # print(len(tranfeatsmap))
    raw_file.seek(0)
    for line in raw_file:
        cnt = cnt + 1
        line = line.strip()
        attrs = line.split(',')
        transtr = ''
        # if len(attrs) < attrslen:
        #     # print(attrs)
        #     print(cnt)
        #     break
        for i in range(0, attrslen):
            if attrs[i] not in tranfeatsmap[i]:
                curidx = len(tranfeatsmap[i])
                tranfeatsmap[i][attrs[i]] = curidx
            transtr += ' %d:%d'%(i+1, tranfeatsmap[i][attrs[i]])
        transtr = '%d'%tranfeatsmap[attrslen - 1][attrs[attrslen - 1]] + transtr
        writebuffers.append(transtr)
        # print(transtr)
    # for i in range(0, attrslen):
    #     print(tranfeatsmap[i])
    # print(writebuffers[0])
    # print(writebuffers[1])
with open(os.path.join(script_dir, "..", "resources", "kr-vs-kp.txt"), 'w') as outfile:
    for line in writebuffers:
        print(line, file=outfile)