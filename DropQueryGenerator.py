create_script = open("Create.sql", 'r')

output = open("Drop.sql", 'w')

for line in create_script.readlines():
    words = line.strip().split(" ")
    if words[0] == "CREATE":
        query = "DROP TABLE " + words[2].replace("(","") + " CASCADE CONSTRAINTS;\n"
        output.write(query)
        
create_script.close()
output.close()
