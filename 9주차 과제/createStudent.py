import random
import numpy as np


first = '김이박정윤최장한오우배변곽공류홍표조주도신은혜선명진수국종경'
second = '김이박정윤최장한오우배변곽공류홍표조주도신은혜선명진수국종경'
third = '김이박정윤최장한오우배변곽공류홍표조주도신은혜선명진수국종경'

one = 'abcdefghijklmnopqrstuvwxyz'
two = 'abcdefghijklmnopqrstuvwxyz'
three = 'abcdefghijklmnopqrstuvwxyz'

Dnumber= [23410, 16522, 20001, 45200, 75221];
majorName=['공간정보공학', '통계학', '아태물류학', '정보통신공학', '경영학']
classId=['ABC1002001', 'ABC2001002', 'ICE4002001', 'ICE2001003', 'EFG3003001', 'WSE4005002', 'WSE1005001', 'VEF2001002']

ssnList = []
base1 = "INSERT INTO STUDENT (S_id, S_name, S_email, major, D_id, S_phone_number) VALUES "
base2 = "INSERT INTO TAKE_CLASS (S_id, C_id) VALUES "

sql = []
for i in range(100000):
    if i % 10000 == 0: print(i)
    f_idx = random.randint(0, len(first)-1)
    s_idx = random.randint(0, len(first)-1)
    t_idx = random.randint(0, len(first)-1)
    d_idx = random.randint(0, 4)
    c_idx = random.randint(0, 7)
    o_idx = random.randint(0, len(one)-1)
    tw_idx = random.randint(0, len(one)-1)
    th_idx = random.randint(0, len(one)-1)
    ssn = random.randint(11111111, 99999999);
    while ssn in ssnList:
        ssn = random.randint(111111111, 999999999);
    ssnList.append(ssn)
    
    S_id = ssn
    S_name = first[f_idx] + second[s_idx] + third[t_idx]
    S_email = one[o_idx] + two[tw_idx] + three[th_idx] +'@'+ 'test.com'
    major = majorName[d_idx]
    D_id = Dnumber[d_idx]
    S_phone_number = '010' + (str(random.randint(1, 99999999))).zfill(8)
    C_id = classId[c_idx]
    

    query1 = base1 + '("' + str(S_id) + '", "' + S_name + '", "' + S_email + '", "' + major + '", "' + str(D_id) + '", "' + S_phone_number + '");\n'
    query2 = base2 + '("' + str(S_id) + '", "' + C_id + '");\n'

    query = query1 + query2
    sql.append(query);

f = open('test.sql', 'w')
for i, s in enumerate(sql):
    f.writelines(s)

f.close()