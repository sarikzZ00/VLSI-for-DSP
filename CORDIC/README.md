CORDIC for instantaneous frequency estimation. 
The top level diagram is shown below:
![top_level_diagram3](https://github.com/user-attachments/assets/9b82101e-929e-4536-9661-be9f78d2018c)

CORDIC has a pipeline depth of 14 and it supports both vectoring and rotation modes. 
The normalized instantaneous frequency of the signal 𝑥[𝑛] = 𝐴[𝑛]𝑒^(j*𝜃[n])
(𝐴[𝑛] is the amplitude and 𝜃[𝑛] is the angle of the signal) is defined by 𝑓_inst[𝑛] = 𝑤𝑟𝑎𝑝(𝜃[𝑛] −
𝜃[𝑛 − 1]) where 𝑤𝑟𝑎𝑝(Δ𝜃) = 
Δ𝜃 𝑖𝑓 − 𝜋 < Δ𝜃 < 𝜋
Δ𝜃 − 2𝜋 𝑖𝑓 Δ𝜃 > 𝜋
Δ𝜃 + 2𝜋 𝑖𝑓 Δ𝜃 < −𝜋
is a function to keep the normalized frequency
within the range of (−𝜋, 𝜋). That is, the instantaneous frequency is the difference of phases of adjacent
samples.
