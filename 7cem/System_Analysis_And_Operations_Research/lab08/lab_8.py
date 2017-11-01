from collections import defaultdict
import numpy as np

def load_graph(filename):
    with open(filename, 'r') as f:
        n = int(f.readline())
        start_v, end_v = map(int,f.readline().split())
        c = np.zeros((n, n))
        for line in f:
            u, v, w = map(int, line.split())
            c[u, v] = w

    return c, start_v, end_v

def bfs(G, start_v, end_v):
    visited = set()
    queue = []
    parent = {}

    visited.add(start_v)
    queue.append(start_v)

    while queue:
        u = queue.pop()
        for v in G[u]:
            if v not in visited:
                queue.append(v)
                visited.add(v)
                parent[v] = u

    path = []
    if end_v in visited:
        path.append(end_v)
        while True:
            v = parent[path[-1]]
            path.append(v)
            if v == start_v:
                break

    return path

def get_residual_network(c, f):
    c_f = c - f
    G_f = defaultdict(list)

    n, m = c_f.shape

    for i in range(n):
        for j in range(m):
            if c_f[i, j] > 0:
                G_f[i].append(j)

    return G_f, c_f

def get_path_in_residual_network(G_f, start_v, end_v):
    path = bfs(G_f, start_v, end_v)
    if path:
        path = [(path[i+1], path[i]) for i in range(len(path)-1)][::-1]

    return path

def ford_fulkerson(c, start_v, end_v):
    n, m = c.shape
    f = np.zeros((n, m))
    max_flow = 0
    while True:
        G_f, c_f = get_residual_network(c, f)  
        path = get_path_in_residual_network(G_f, start_v, end_v)
        if not path:
            break

        c_min = min([c_f[i, j] for i, j in path])
        max_flow += c_min
        for u, v in path:
            f[u, v] += c_min
            f[v, u] -= c_min

    return f, max_flow


args = load_graph('08')
f, max_flow = ford_fulkerson(*args)

print (max_flow)



