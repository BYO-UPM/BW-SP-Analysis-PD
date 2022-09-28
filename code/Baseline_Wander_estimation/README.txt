This demo contains the implementation of several baseline wander (BW)
estimation methods for smooth pursuit eye movements (SPEM) from
Parkinson's disease (PD) patients. For more information, check our paper:
'Baseline wander estimation methods applied to smooth pursuit eye movements 
from parkinsonian patients.'
The software is implemented in MATLAB R2021a and includes a graphical user 
interface (GUI). The GUI allows inputting any of the four sequences used 
in the paper: HF011, HG051, HG023, and HG059. Furthermore, it plots the 
gaze, target, and ground truth (GT) of the left and right eyes.
Besides, different BW estimation methods are available (EMD, VMD, FDM, 
EWT, MAF, IIR, and EMD2); thus, selecting or unselecting some of them to 
compare their performance is possible.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

* The estimation of BW based on the EMD2 method is based on the function 
“EMDRemoveBL” which is part of the repository: 
https://github.com/fperdigon/ECG-BaseLineWander-Removal-Methods?utm_source=catalyzex.com,
published under the MIT license by "Francisco Perdigon Romero".
Copyright (c) 2018 Francisco Perdigon Romero
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

** The estimation of BW based on the FDM method is based on the function 
"sp_DFTOrthogonalOrFIR_IIR_LINOEP" (and the "sp_IFFT_Filter” sub-function). 
These functions are part of this toolbox:
https://www.researchgate.net/publication/339528806_MATLAB_Code_Of_FDM_based_on_DCT_DFT_FIR_FSAS_FEB_2020, 
developed by Pushpendra Singh (spushp@gmail.com).
The inclusion of those functions in the present repository got 
the express permission from their author.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
This software is published under MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

To run the GUI:
1- Open the Baseline_Wander_estimation.fig file using GUIDE and press the run button there (F5).
2- Open the Baseline_Wander_estimation.m file and press the run button there.
3- Type "Baseline_Wander_estimation" in the command window and press Enter button. 


