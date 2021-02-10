using ITensors
using ITensorsVisualization

N = 10
s(n) = Index([QN("Sz", 0) => 1, QN("Sz", 1) => 1]; tags = "S=1/2,Site,n=$n")
l(n) = Index([QN("Sz", 0) => 10, QN("Sz", 1) => 10]; tags = "Link,l=$n")
h(n) = Index([QN("Sz", 0) => 5, QN("Sz", 1) => 5]; tags = "ham,Link,l=$n")
s⃗ = [s(n) for n in 1:N]
l⃗ = [l(n) for n in 1:N-1]
h⃗ = [h(n) for n in 1:N-1]

# Add some more indices between two of the tensors
x = Index([QN("Sz", 0) => 2]; tags = "X")
y = Index([QN("Sz", 0) => 2]; tags = "Y")

n = 2
ψn1n2 = randomITensor(l⃗[n-1], s⃗[n], s⃗[n+1], l⃗[n+1], dag(x), dag(y))
hn1 = randomITensor(dag(h⃗[n-1]), s⃗[n]', dag(s⃗[n]), h⃗[n], x, y)
hn2 = randomITensor(dag(h⃗[n]), s⃗[n+1]', dag(s⃗[n+1]), h⃗[n+1])
ELn0 = randomITensor(l⃗[n-1]', h⃗[n-1], dag(l⃗[n-1]))
ERn2 = randomITensor(l⃗[n+1]', dag(h⃗[n+1]), dag(l⃗[n+1]))

R = @visualize ELn0 * ψn1n2 * hn1 * hn2 * ERn2 pause = true
@show R ≈ ELn0 * ψn1n2 * hn1 * hn2 * ERn2

# Split it up into multiple contractions
R1 = @visualize ELn0 * ψn1n2 * hn1 pause = true
R2 = @visualize R1 * hn2 * ERn2 pause = true
@show R2 ≈ ELn0 * ψn1n2 * hn1 * hn2 * ERn2

