from numpy import *


def swap(a, b):
    temp = a[:]
    a = b[:]
    b = temp[:]
    return a, b


def GetSpectialEdgeIndex(graph ,source, destination):
    for edge in graph:
        if source == edge.source and destination == edge.destination:
            return graph.index(edge)

def GetBasis(n, graph):
    basis = {i: [] for i in range(n)}
    for i in range(n):
        for j in range(len(graph.edges)):
            if graph.edges[j].isBasis:
                if i == graph.edges[j].source:
                    basis[i].append(graph.edges[j].destination)
                    basis[graph.edges[j].destination].append(i)
    return basis


def dfs_u(v, g, S, u, used):
    used[v] = True
    for to in g[v]:
        if not used[to]:
            for elem in S.edges:
                if v == elem.source and to == elem.destination:
                    u[to] = u[v] - elem.cost
                elif v == elem.destination and to == elem.source:
                    u[to] = u[v] + elem.cost
            dfs_u(to, g, S, u, used)


def GetPotentials(n, g, S):
    used = [False for _ in range(n)]
    u = [inf for _ in range(n)]
    u[0] = 0
    dfs_u(0, g, S, u, used)
    return u


def GetDeltasEdgesAndValues(S, u):
    delta = []
    for edge in S.edges:
        if not edge.isBasis:
            delta.append(((edge.source, edge.destination), u[edge.source] - u[edge.destination] - edge.cost))
    return delta


def dfs(v, color, p, g):
    color[v] = 1
    for to in g[v]:
        if color[to] == 0:
            p[to] = v
            if dfs(to, color, p, g):
                return True
        elif (color[to] == 1) and (p[v] != to):
            global cycle_st
            global cycle_end
            cycle_end = v
            cycle_st = to
            return True

    color[v] = 2
    return False


def cycle(uu, n, g):
    color = []
    p = []
    for i in range(n):
        color.append(0)
        p.append(-1)
    _cycle = []
    if dfs(uu, color, p, g):

        v = cycle_end
        while v != cycle_st:
            _cycle.append(v)
            v = p[v]

        _cycle.append(cycle_st)

    return _cycle


def GetMaxDelta(delta):
    values = [i[1] for i in delta]
    return delta[argmax(values)][0], max(values), argmax(values)


def matrics_network_task(n, S):
    net = PotentialGragh(S)
    while True:
        bas = GetBasis(n, net)
        pot = GetPotentials(n, bas, net)
        delta = GetDeltasEdgesAndValues(net, pot)
        max_delta_edge_i0j0, max_delta_value, max_delta_ind = GetMaxDelta(delta)
        if max_delta_value <= 0:
            sum = 0
            for elem in net.edges:
                sum += elem.x * elem.cost # x * cost

            print(sum)
            [print(str(edge.source+1)+":"+str(edge.destination+1)+" "+str(edge.x)) for edge in net.edges]
            return net.edges

        for edge in net.edges:
            if edge.source == max_delta_edge_i0j0[0] and edge.destination == max_delta_edge_i0j0[1]:
                edge.isBasis = True

        g2 = GetBasis(n, net)
        U = cycle(max_delta_edge_i0j0[0], n, g2)
        U.reverse()
        U.append(U[0])
        U_basis_plus = []
        U__basis_minus = []
        for edge in range(len(U) - 1):
            for elem in net.edges:
                if U[edge] == elem.source and U[edge + 1] == elem.destination:
                    U_basis_plus.append((U[edge], U[edge + 1]))
                elif U[edge] == elem.destination and U[edge + 1] == elem.source:
                    U__basis_minus.append((U[edge + 1], U[edge]))

        if max_delta_edge_i0j0 not in U_basis_plus:
            U__basis_minus, U_basis_plus = swap(U__basis_minus, U_basis_plus)

        tetta = []
        for elem in net.edges:
            tupl = (elem.source, elem.destination)
            if tupl in U__basis_minus:
                tetta.append((tupl, elem.x))

        tetta0 = min([tetta[i][1] for i in range(len(tetta))])

        for elem in tetta:
            if elem[1] == tetta0:
                curve_star = elem[0]
                break

        for curve in U_basis_plus:
            net.edges[GetSpectialEdgeIndex(net.edges, curve[0], curve[1])].x += tetta0

        for curve in U__basis_minus:
            net.edges[GetSpectialEdgeIndex(net.edges, curve[0], curve[1])].x -= tetta0

        net.edges[GetSpectialEdgeIndex(net.edges, curve_star[0], curve_star[1])].isBasis = False



class Edge:
    def __init__(self, rawEdge):
        self.source = rawEdge[0]
        self.destination = rawEdge[1]
        self.cost = rawEdge[2]
        self.x = rawEdge[3]
        self.isBasis = True if rawEdge[4] == 1 else False


class PotentialGragh:
    def __init__(self, rawdata):
        self.raw = rawdata
        self.edges = self.GetEdges()

    def GetEdges(self):
        edgesList = list()
        for i in self.raw:
            edge = Edge(i)
            edgesList.append(edge)
        return edgesList


def GetInput(path="05"):
    raw =  []
    with open(path) as f:
        for line in f.readlines():
            raw.append([int(number) for number in line.split(" ")])
    return raw

n = 7
res = matrics_network_task(7, GetInput('05'))

