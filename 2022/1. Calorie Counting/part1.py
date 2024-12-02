import os

path = os.getcwd()
filePath = path + "/input"
f = open(filePath, "r")

maxCalories = 0
currentCalories = 0

def countLine(line):
    global maxCalories
    global currentCalories
    try:
        number = int(line)
        currentCalories += number
    except:
        if currentCalories > maxCalories:
            maxCalories = currentCalories
        currentCalories = 0

with open(filePath, 'rb') as f:
    while True:
        line = f.readline()
        if not line:
            break
        countLine(line)

print(maxCalories)
