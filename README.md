# Simulation-and-Modeling-of-Dynamic-Systems-Auth-2022
This project contains files from the 2022 projects in the Simulation and Modeling of Dynamic Systems course in Aristotle University of Thessaloniki.

# Project 1

The goal of the first project is estimating the parameters of two dynamic systems using the least squares method

**Query 1**
- Applying the least squares algorithm on the following system.
- Estimating the parameters m,b and k.

![shape1](./Project%201/graphs/query1_graph.png)

**Query 2** 

- Estimating the L,R,C parameters and the transfer function of the following system using the least squares method.
- Observing the error impact on the parameter estimation when using the least squares method.

![shape2](./Project%201/graphs/query2_graph.png)

# Project 2

The goal of the second project is the on line estimation of unknown parameters of a system using the gradient and Lyapunov method

**Query 1**
For the system described by the following differential equation: 
$$
\begin{align}
\dot{x} = -αx + bu, x(0)=0
\end{align}
$$
i) Design an online estimator for the unknown parameters using the gradient method and simulate its function for input u=3.
ii) Design an online estimator for the unknown parameters using the gradient method and simulate its function for input u(t) = 3cos(2t)

**Query 2**
For the system described by the following differential equation: 

$$
\begin{align}
\dot{x} = -αx + bu
\end{align}
$$
i) Design a Lyapunov-based online parameter estimator for the unknown parameters

ii) Simulate its function for input noise $η(t)$

# Project 3
For the following second order system:
$$
\begin{align}
\dot{x} = 
\begin{bmatrix}
a_{1,1} & a_{1,2} \\
a_{2,1} & a_{2,2}
\end{bmatrix}
x + 
\begin{bmatrix}
b_1 \\ b_2
\end{bmatrix}
u, \quad x_0 = 
\begin{bmatrix}
0 \\ 0 
\end{bmatrix}
\end{align}
$$
i) Design a Lyapunov-based online parameter estimator for the unknown parameters

ii) Simulate its function 