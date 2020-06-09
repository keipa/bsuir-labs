#!/usr/bin/python2.7
from numpy import *
import scipy.stats as st


def getTime(begin, end):
    uniform = st.uniform(loc=begin, scale=end - begin)
    return uniform.rvs(size=1)


def work(time_now):
    return getTime(0, 1) + time_now


def imitationCompletionOfServiceRequestsByChannelK31(matrix_state_channel, T, time_now, count_served_requirements):
    if matrix_state_channel[2, 0] == 1:
        if T[2, 0] <= time_now:
            matrix_state_channel[2, 0] = 0
            count_served_requirements += 1

    return matrix_state_channel, count_served_requirements


def imitationCompletionOfPhase2AndTransfer3(matrix_state_channel, T, time_now):
    j = 0
    while(j <= 1):
        if matrix_state_channel[1, j] != 0:
            if T[1, 0] <= time_now:
                if matrix_state_channel[2, 0] == 0:
                    T[2, 0] = work(time_now)
                    matrix_state_channel[2, 0] = 1
                    matrix_state_channel[1, j] = 0
                else:
                    matrix_state_channel[1, j] = 2

        j += 1

    return matrix_state_channel, T


def transferRequirementsFromAccumulator2phaseToChannels2(state_accumulator, matrix_state_channel, T, time_now):
    j = 0
    while(j <= 1):
        if state_accumulator[1] > 0:
            if matrix_state_channel[1, j] == 0:
                T[1, j] = work(time_now)
                matrix_state_channel[1, j] = 1
                state_accumulator[1] -= 1

        j += 1

    return matrix_state_channel, T, state_accumulator


def transferRequirementsFromChannel1phaseToAccumulator2Phase(state_accumulator, capacity_accumulator, matrix_state_channel, T, time_now):
    l = 0
    j = 0
    bol = True
    while(j <= 1):
        if matrix_state_channel[0, j] != 0:
            if T[0, j] <= time_now:
                while(l <= 1):
                    if matrix_state_channel[1, l] != 0:
                        l += 1
                    else:
                        bol = False
                        T[1, l] = work(time_now)
                        matrix_state_channel[1, l] = 1
                        matrix_state_channel[0, j] = 0
                        break

                if bol:
                    if state_accumulator[1] < capacity_accumulator[1]:
                        state_accumulator[1] += 1
                        matrix_state_channel[0, j] = 0
                    else:
                        matrix_state_channel[0, j] = 2

        j += 1

    return matrix_state_channel, T, state_accumulator


def transferRequirementsFromAccumulator1phaseToChannels1(state_accumulator, matrix_state_channel, T, time_now):
    j = 0
    while(j <= 1):
        if state_accumulator[0] > 0:
            if matrix_state_channel[0, j] == 0:
                T[0, j] = work(time_now)
                matrix_state_channel[0, j] = 1
                state_accumulator[0] -= 1

        j += 1

    return matrix_state_channel, T, state_accumulator


def transferRequirementsFromSourceToPhase1(state_accumulator, capacity_accumulator, matrix_state_channel, T, time_now, time_end, count_lost_requirements, delta):
    bol = True
    if time_now < time_end:
        j = 0
        while(j <= 1):
            if matrix_state_channel[0, j] == 0:
                T[0, j] = work(time_now)
                matrix_state_channel[0, j] = 1
                bol = False
                break

            j += 1

        if bol:
            if state_accumulator[0] < capacity_accumulator[0]:
                state_accumulator[0] += 1
            else:
                count_lost_requirements += 1

        time_now += delta

    return matrix_state_channel, T, state_accumulator, count_lost_requirements, time_now


def sistemMassService():
    n_iters = 100 # kol-vo zayavok
    matrix_end_of_service_time = zeros((3, 2)) # vremya okonchaniya
    capacity_accumulator = [10, 10] 
    state_accumulator = [0, 0]
    count_lost_requirements = 0
    count_served_requirements = 0
    time_now = 0.0
    deltaT = 0.2
    time_end = n_iters * deltaT
    matrix_state_channel = zeros((3, 2))
    for i in xrange(100):
        matrix_state_channel, count_served_requirements = imitationCompletionOfServiceRequestsByChannelK31(matrix_state_channel, matrix_end_of_service_time, time_now, count_served_requirements)
        matrix_state_channel, matrix_end_of_service_time = imitationCompletionOfPhase2AndTransfer3(matrix_state_channel, matrix_end_of_service_time, time_now)
        matrix_state_channel, matrix_end_of_service_time, state_accumulator = transferRequirementsFromAccumulator2phaseToChannels2(state_accumulator, matrix_state_channel, matrix_end_of_service_time, time_now)
        matrix_state_channel, matrix_end_of_service_time, state_accumulator = transferRequirementsFromChannel1phaseToAccumulator2Phase(state_accumulator, capacity_accumulator, matrix_state_channel, matrix_end_of_service_time, time_now)
        matrix_state_channel, matrix_end_of_service_time, state_accumulator = transferRequirementsFromAccumulator1phaseToChannels1(state_accumulator, matrix_state_channel, matrix_end_of_service_time, time_now)
        matrix_state_channel, matrix_end_of_service_time, state_accumulator, count_lost_requirements, time_now = transferRequirementsFromSourceToPhase1(state_accumulator, capacity_accumulator, matrix_state_channel, matrix_end_of_service_time, time_now, time_end, count_lost_requirements, deltaT)

    print count_served_requirements
    print count_lost_requirements
    print state_accumulator


if __name__ == "__main__":
    sistemMassService()
