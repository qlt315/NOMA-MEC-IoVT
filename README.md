# NOMA-MEC-IoVT
Evaluation code of our paper in IEEE Transactions on Vehicular Technology: ''Joint Transmission and Resource Optimization in
NOMA-assisted IoVT with Mobile Edge Computing"

Special thanks to FengqianGuo@Tencent for his support of the coding works！

Abstract: Internet of Video Things (IoVT) brings much higher requirements on the transmission and computing capabilities of wireless networks than traditional Internet of Things (IoT). Nonorthogonal multiple access (NOMA) and mobile edge computing (MEC) have been considered as two promising technologies to satisfy these requirements. However, successive interference cancellation (SIC) and grouping operations in NOMA as well as delay sensitive IoVT video tasks with different priorities make it challenging to achieve the optimal performance in NOMA assisted IoVT with MEC. To address this issue, we formulate a joint optimization problem where both NOMA operations and MEC offloading are involved, with the goal to minimize the weighted average total delay. To tackle such intractable problem, we proposed a graph theory-based optimization framework, then decompose and transform the problem into finding negative loops in the weighted directed graph. Specifically, we design a priority-based SIC decoding mechanism and propose convex optimization-based power allocation and computing resource allocation algorithms to calculate the adjacency matrix. Then, two negative loop searching algorithms are adopted to obtain the device association and grouping strategies. Simulation results demonstrate that compared with existing algorithms, the proposed algorithm reduces the weighted average total delay by up to 92.43% as well as improves the transmission rate of IoVT devices by up to 79.1%.

Please run main_xxx.m files to compare different optimization algorithms.

Running Environment: MATLAB 2023a & CVX 3.0

This paper is available on https://ieeexplore.ieee.org/document/10430407
