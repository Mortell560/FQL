import random

with open("c:/Users/ambre/Documents/GitHub/FQL/SQL_scripts/Sportifs.sql", 'w') as f:
    sportifs_par_comp = [32,40,24,5,10,5,10,2,5,6,6,32,32,40,40,24,24,10,6,5,32]
    non_select = [1,2,3,4,5,8,10,12,14,16,18,20,21,22,27]
    for i in range(len(sportifs_par_comp)):
        seen_id = []
        while len(seen_id)<sportifs_par_comp[i]:
            id = random.randint(6,1000)
            if id not in non_select:
                seen_id.append(id)
                non_select.append(id)
        for id in seen_id :
            f.write(
                f"INSERT INTO Role VALUES ({id}, {i+1}, 1, 0, 0);\n"
            )
        f.write(
                f"\n"
            )
