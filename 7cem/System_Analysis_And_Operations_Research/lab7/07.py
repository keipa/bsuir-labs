from numpy import *


def createCurrentIndexes(graph, mark):
    currentIndexes = set()
    for elem in mark:
        for index in range(len(graph[elem])):
            if 0 < graph[elem][index] < inf:
                if index in mark:
                    break
                currentIndexes.add(index)
    return currentIndexes


def checkIndexes(check):
    setIndex = []
    for index in range(len(check)):
        if 0 < check[index] < inf:
            setIndex.append(index)
    return setIndex


def findIndexes(graph, mark):
    currentIndexes = createCurrentIndexes(graph, mark)
    for elem in currentIndexes:
        check = []
        for row in graph:
            check.append(row[elem])
        current = checkIndexes(check)
        checkMark = []
        for index in current:
            if index not in mark:
                checkMark.append(False)
                break
            else:
                checkMark.append(True)
        if all(checkMark):
            return elem
    return False


def main(graph, mark):
    if len(mark) == len(graph):
        return

    index = findIndexes(graph, mark)

    if not index:
        print("No solution")
    else:
        mark.append(index)
        path = []
        for ind in range(len(vectorB)):
            if vectorB[ind] != inf and graph[ind][index] != inf:
                path.append((ind, graph[ind][index]))
        currentMaxPath = -1
        currentPath = -1
        for pairIndexAndPath in path:
            if vectorB[pairIndexAndPath[0]] > currentMaxPath:
                currentMaxPath = vectorB[pairIndexAndPath[0]]
                currentPath = pairIndexAndPath[1]

        vectorB[index] = currentMaxPath + currentPath


if __name__ == "__main__":
    with open('07.txt') as file:
        n, start, finish = [int(elem) for elem in file.readline().split() if elem != ""]
        graph = zeros((n, n))
        for i in range(n):
            graph[i] = [float(elem) for elem in file.readline().split() if elem != ""]

        vectorB = [inf] * n
        vectorB[start] = 0
        mark = [start]

        for count in range(len(graph)):
            main(graph, mark)

        print("Max path from", start, "to", finish, "=", vectorB[finish])
