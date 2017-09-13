#python27
from matplotlib import pyplot
from MidSquareMethod import MidSquareMethod
from MultiplicativeCongruentialMethod import MultiplicativeCongruentialMethod

def GetCorrelation(z, s=3):
    r = 12 * (1.0 / (len(z) - s)) * sum([z[i] * z[i + s] for i in xrange(len(z) - s)]) - 2.8
    return r

def ShowMathCoeffs(z):
    mathematicalExpectation = sum(z) / len(z)
    dispersion = sum([z[i] ** 2 - mathematicalExpectation ** 2 for i in xrange(len(z))]) / len(z)
    print 'len {0}. Mat. ojidanie = {1}. dispersion = {2}'.format(len(z), mathematicalExpectation, dispersion)


def ShowPlot(z):
    pyplot.style.use('seaborn')
    pyplot.subplot(1, 1, 1)
    pyplot.hist(z, color='C2')
    pyplot.show()

def M(arr):
    return reduce(lambda x,y:x+y,arr)/len(arr)

def D(arr):
    arr2 = [i for i in map(lambda x:x*x,arr)]
    return M(arr2)-pow(M(arr),2)

def R(x,y):
    Mxy = M([i*j for i,j in zip(x,y)])
    MxMy = M(x)*M(y)
    DxDy = D(x)*D(y)
    return (Mxy-MxMy)/(pow(DxDy,0.5))


# phase 1
while True:
    try:
        sourceNumber = int(raw_input('Input source (1994 for check) or type "Q" to exit:'))
        count = int(raw_input('Input count (20 forfor check) or type "Q" to exit:'))
    except Exception:
        break
    z = MidSquareMethod(sourceNumber, count)
    print z
    ShowPlot(z)

print 'phase 2'
#phase 2
pyplot.figure(figsize=(6, 6))
while True:
    try:
        countOfNumbers = int(raw_input('Input count or type "Q" to exit:'))
    except Exception:
        break
    z = MultiplicativeCongruentialMethod(countOfNumbers)
    ShowPlot(z)
    ShowMathCoeffs(z)
    print GetCorrelation(z)

defaultConfig = {'m': 2 ** 31, 'k': 987654321, 'A0': 2}
print R(MultiplicativeCongruentialMethod(1000, defaultConfig), MultiplicativeCongruentialMethod(10000))







