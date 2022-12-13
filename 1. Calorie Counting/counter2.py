import os

path = os.getcwd()
filePath = path + "/input"
f = open(filePath, "r")

maxCalories = 0
currentCalories = 0
maxCaloriesArr = []

def countLine(line):
    global maxCalories
    global currentCalories
    try:
        number = int(line)
        currentCalories += number
    except:
        if currentCalories > maxCalories:
            maxCalories = currentCalories
            maxCaloriesArr.append(maxCalories)
        currentCalories = 0

with open(filePath, 'rb') as f:
    while True:
        line = f.readline()
        if not line:
            break
        countLine(line)

print(sum(maxCaloriesArr[-3:]))
# print(maxCalories)
