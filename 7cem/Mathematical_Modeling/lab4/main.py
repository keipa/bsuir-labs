from goto import with_goto
from MultiplicativeCongruentialMethod import MultiplicativeCongruentialMethod
import numpy as np
import matplotlib.pyplot as plt

global TN, ZN, N3, N1, Z3, Z2, Z1, T3, T2, T1, L, TM, TC


def GetTime():
    random = MultiplicativeCongruentialMethod(10000)
    for newRand in random:
        yield int(newRand * 10) % 5 + 1


class S:
    TN = 0  # time now / model time
    ZN = ["заполененный объём накопителей", 0, 0, 0]  #
    N3 = 0  # полностью обслуженные заявки
    N1 = 0  # отклонённые заявки

    # состояния каналов
    # 0 свободен
    # 1 занят
    # 2 заблокирован
    G = GetTime()
    Z3 = ["состояние третьего канала", 0]
    Z2 = ["состояние каналов второй фазы", 0, 0]
    Z1 = ["состояние каналов первой фазы", 0, 0]
    T3 = ["момент времени когда заявка будет обслужена 3м каналом", 0]
    T2 = ["момент времени когда заявка будет обслужена 2м каналом", 0, 0]
    T1 = ["момент времени когда заявка будет обслужена 1м каналом", 0, 0]
    L = ["максимальная ёмкость накопителей", 5, 4]
    TM = 0  # момент времени появления след. заявки
    TC = 100  # общее кол-во пришедших заявок
    TT = 100  # общее кол-во пришедших заявок
    # # plt.ion()
    # plotUpdate = 0.0005
    times = []
    zn1 = []
    zn2 = []
    neworder = []
    z11 = []
    z12 = []
    z21 = []
    z22 = []


def OutputResults():
    pass


def CollectData():
    S.times.append(S.TN)
    S.zn1.append(S.ZN[1])
    S.zn2.append(S.ZN[2])
    if S.TM == S.TN:
        S.neworder.append(0)
    else:
        S.neworder.append(-3)
    S.z11.append(S.Z1[1])
    S.z12.append(S.Z1[2])
    S.z21.append(S.Z2[1])
    S.z22.append(S.Z2[2])


def IsModelEnded():
    # if S.TC == 0:
    if S.N1 + S.N3 == S.TT and S.N3 != 0:
        return True
    else:
        return False


def ProcessingResults():
    print("Time", S.TN)
    print("Отклонено:", S.N1)
    print("Обработано:", S.N3)
    # print("Заявок осталось в системе:", -S.TC)


def ServingOrderThirdPhase():
    if S.Z3[1] == 1:
        if S.T3[1] == S.TN:
            S.N3 += 1
            S.Z3[1] = 0
            S.T3[1] = 0
        else:
            return
    else:
        return


def WORK():
    return S.TN + next(S.G)


@with_goto
def TransferFromSecondToThirdPhase():
    J = 1
    label.one
    if S.Z2[J] != 0:
        if S.T2[J] <= S.TN:
            if S.Z3[1] == 0:
                S.T3[1] = WORK()
                S.Z3[1] = 1
                S.T2[J] = 0
                S.Z2[J] = 0
            else:
                S.Z2[J] = 2
    if J >= 2:
        return
    else:
        J += 1
        goto.one


@with_goto
def ServingOrderSecondPhase():
    J = 1
    label.two
    if S.ZN[2] > 0:
        if S.Z2[J] == 0:
            S.T2[J] = WORK()
            S.Z2[J] = 1
            S.ZN[2] -= 1
        if J >= 2:
            return
        else:
            J += 1
            goto.two
    else:
        return


@with_goto
def TransferFromFirstToSecondPhaseQueue():
    J = 1
    label.three
    if S.Z1[J] != 0:
        if S.T1[J] <= S.TN:
            I = 1
            label.begin
            if S.Z2[I] != 0:
                if I >= 2:
                    if S.ZN[2] < S.L[2]:
                        S.ZN[2] = S.ZN[2] + 1
                        S.Z1[J] = 0
                        if J >= 2:
                            return
                        else:
                            J += 1
                            goto.three
                    else:
                        S.Z1[J] = 2
                        if J >= 2:
                            return
                        else:
                            J += 1
                            goto.three
                else:
                    I += 1
                    goto.begin
            else:
                S.T2[I] = WORK()
                S.T1[J] = 0
                S.Z2[I] = 1
                S.Z1[J] = 0
                if J >= 2:
                    return
                else:
                    J += 1
                    goto.three
        else:
            if J >= 2:
                return
            else:
                J += 1
                goto.three

    else:
        if J >= 2:
            return
        else:
            J += 1
            goto.three


@with_goto
def ServingOrderFisrtPhase():
    J = 1
    label.four
    if S.ZN[1] != 0:
        if S.Z1[J] == 0:
            S.Z1[J] = WORK()
            S.Z1[J] = 1
            S.ZN[1] = S.ZN[1] - 1
            if J >= 2:
                J += 1
                goto.four
            else:
                return
        if J >= 2:
            J += 1
            goto.four
        else:
            return
    if J >= 2:
        J += 1
        goto.four
    else:
        return


@with_goto
def GetOrderOnStarts():
    if S.TM == S.TN:
        J = 1
        label.five
        if S.Z1[J] == 0:
            S.T1[J] = WORK()
            S.Z1[J] = 1
            D()
            return
        else:
            if J >= 2:
                if S.ZN[1] < S.L[1]:
                    S.ZN[1] += 1
                    D()
                    return
                else:
                    S.N1 += 1
                    D()
                    return
            else:
                J += 1
                goto.five


def D():  # получить время новой заявки
    a = next(S.G)
    S.TM = S.TN + a
    S.TC = S.TC - 1


def GoToNewTimeSnapshot():
    S.TN += 1


def ShowBeautifulPlot():
    plt.axis([0, S.TN, -2.5, max(S.L[1:])])
    plt.axhline(y=S.L[1], xmin=0, xmax=1000, c="blue", linewidth=2, zorder=1)  # max ёмкость первой очереди
    plt.axhline(y=S.L[2], xmin=0, xmax=1000, c="red", linewidth=2, zorder=1)  # max ёмкость второй очереди

    for index, qu in enumerate(S.zn1):
        plt.bar(index, qu, 1, color='#76a8f7', alpha=0.7)
    for index, qu in enumerate(S.zn2):
        plt.bar(index, qu, 1, color='#f77575', alpha=0.7)

    for index, qu in enumerate(S.z11):
        if qu == 1:
            plt.scatter(index, -1, c="r", marker="^", alpha=0.5)
        if qu == 2:
            plt.scatter(index, -2, c="r", marker="^", alpha=0.5)

    for index, qu in enumerate(S.z12):
        if qu == 1:
            plt.scatter(index, -1, c="r", marker="v", alpha=0.5)
        if qu == 2:
            plt.scatter(index, -2, c="r", marker="v", alpha=0.5)

    for index, qu in enumerate(S.z21):
        if qu == 1:
            plt.scatter(index, -1, c="b", marker="^", alpha=0.5)
        if qu == 2:
            plt.scatter(index, -2, c="b", marker="^", alpha=0.5)

    for index, qu in enumerate(S.z22):
        if qu == 1:
            plt.scatter(index, -1, c="b", marker="v", alpha=0.5)
        if qu == 2:
            plt.scatter(index, -2, c="b", marker="v", alpha=0.5)


    plt.plot(S.times, S.neworder, 'go')
    plt.show()
    # plt.pause(S.plotUpdate)


# TODO: sort methods

print("Enterence")  # 0

while True:
    if IsModelEnded():  # 3 da
        ProcessingResults()  # 11
        OutputResults()  # 12
        ShowBeautifulPlot()

        exit()
    else:  # net
        ServingOrderThirdPhase()  # 4
        TransferFromSecondToThirdPhase()  # 5
        ServingOrderSecondPhase()  # 6
        TransferFromFirstToSecondPhaseQueue()  # 7
        ServingOrderFisrtPhase()  # 8
        GetOrderOnStarts()  # 9
        GoToNewTimeSnapshot()  # 10
        CollectData()
