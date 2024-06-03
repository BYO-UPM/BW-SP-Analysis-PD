# Baseline wander estimation methods applied to smooth pursuit eye movements from parkinsonian patients
By M. Bejani, E. Luque-Buzo, A. Burlaka-Petrash, J. A. Gómez-García, J. D. Arias-Londoño, F. Grandas-Pérez, J. I. Godino-Llorente.

IEEE Access, vol. 11, pp. 32119-32133, 2023, doi: 10.1109/ACCESS.2023.3263045.

## Abstract:  

Prior studies aiming to parametrize the sequences obtained from the Smooth Pursuit Eye Movements (SPEM) of patients with Parkinson's disease are based on manual extraction of the required information. This is because methods to automatically extract the relevant information are complex to implement and are constrained, in part, by the appearance of a baseline wander (BW). Thus, new methods are required for preprocessing the SPEM sequences to make the potential parameterization procedures much more robust. In this regard, new methods are required to remove the aforementioned BW. The present study investigates and compares different BW removal methods applied to SPEM sequences based on a set of several objective evaluation metrics. At the same time, it proposes a set of guidelines to estimate the ground truth that is used for comparison purposes. 

Data were collected using a video-based eye tracking device. 52 patients and 60 controls (48 age-matched to the patients and 12 young participants) were enrolled in the study. The ground truth required to compare different techniques of BW estimation was manually delineated according to a predefined protocol. Seven methods were developed to estimate the BW, and four objective metrics were used to evaluate the results. 

According to the metrics used, a method based on the Empirical Wavelet Transform provided the best performance for removing the BW. Also, a method based on the Empirical Mode Decomposition provided very satisfactory results1. Furthermore, the objective and subjective results show that potential asymmetries between left and right eyes movements due to calibration issues are solved by removing the BW of the SPEM. 

Regardless of the techniques used, BW removal in SPEM is revealed to be a crucial step for any autonomous SPEM processing tool. 

# Estimation of the cyclopean eye from binocular Smooth Pursuit Tests
By E. Luque-Buzo, M. Bejani, J. A. Gómez-García, J. D. Arias-Londoño, F. Grandas-Pérez, J. I. Godino-Llorente.

IEEE Transactions on Cognitive and Developmental Systems, in press, 2024 

## Abstract:  

In binocular vision, the visual system combines images in the retina to generate a single perception, which triggers a sensorimotor process that forces the eyes to point to the same target. Thus, following a moving target, both eyes are expected to move synchronously following identical motor triggers but, in practise, significant differences between eyes are found due to the presence of certain artifacts and effects. Thus, a better indirect characterisation of the underlying neurological behaviour during eyes motion would require new automatic preprocessing methods applied to the eye tracking sequences for rendering the common and most significant movements of both eyes.

To address this need, the present study proposes an automatic method for extracting the common components of the left and right eye motions from a set of Smooth Pursuit tests by applying an Independent Component Analysis. To do so, both sequences are decomposed into two independent latent components: the first, presumably correlated with the common motor triggering at the brain, while the second collects artifacts introduced during the recording process and small effects due to convergence deficits and eye dominance biases. 

The evaluations were carried out using data corresponding to 12 different smooth pursuit eye movements tests, which were collected using an infrared high-speed video-based eye tracking device from 41 parkinsonian patients and 47 controls.

The results show that the automatic method can separate the aforementioned components in 99.50\% of cases, extracting a latent component correlated with the common motor triggering at the brain, which we hypothesise is characterising the movements of the cyclopean eye. The estimated component could be used to simplify any other potential automatic analysis.  

## Software Implementation
All source code used to generate the results and figures in the paper are in
the `DEMO` folder.
The data used in this study is provided in `data` and the sources for the
manuscript text and figures are in `manuscript`.
Results generated by the code are saved in `results`.
See the `README.md` files in each directory for a full description.

## Getting the code

You can download a copy of all the files in this repository by cloning the
[git](https://git-scm.com/) repository:

    git clone https://github.com/orgs/BYO-UPM/repositories.git

or [download a zip archive]([https://github.com/orgs/BYO-UPM/repositories/archive/master.zip).

A copy of the repository is also archived at 'DOI'

## Dependecies

You'll need a working Matlab environment to run the code. The recommended way to set up your environment is through MATLAB and Statistics Toolbox Release R2021a, The MathWorks, Inc., Natick, Massachusetts, United States. The software is implemented using Graphical User Interface (GUI).

## Reproducing the results

To run the GUI:
1- Open the Baseline_Wander_estimation.fig file using GUIDE and press the run button there (F5).
2- Open the Baseline_Wander_estimation.m file and press the run button there.
3- Type "Baseline_Wander_estimation" in the command window and press Enter button. 

More information can be found at the 'README' file inside the 'DEMO' directory.

## License

You can freely use and modify the code, without warranty, so long as you provide attribution to the authors. No comercial use can be made. 

M. Bejani, E. Luque-Buzo, A. Burlaka-Petrash, J.A. Gómez-García, J.D. Arias-Londoño, F. Grandas-Pérez, J. Grajal, J.I. Godino-Llorente. Baseline wander removal applied to smooth pursuit eye movements from parkinsonian patients. IEEE Access, vol 11. 2023. [Open access](https://ieeexplore.ieee.org/document/10086500)

E. Luque-Buzo, M. Bejani, J. A. Gómez-García, J. D. Arias-Londoño, F. Grandas-Pérez, J. I. Godino-Llorente. Estimation of the cyclopean eye from binocular Smooth Pursuit Tests. IEEE Transactions on Cognitive and Developmental Systems, in press, 2024 

If you find our work useful, can cite the papers using:

```
@article{bejani2023baseline,
  title={Baseline wander removal applied to smooth pursuit eye movements from parkinsonian patients},
  author={Bejani, M. and Luque-Buzo, E. and Burlaka-Petrash, A. and G{\'o}mez-Garc{\'\i}a, J.A. and Arias-Londo{\~n}o, J.D. and Grandas-P{\'e}rez, F. and Grajal, J. and Godino-Llorente, J.I.},
  journal={IEEE Access},
  volume = {11},
  year={2023},
 }

@article{luqe2024cyclopean,
  title={Baseline wander removal applied to smooth pursuit eye movements from parkinsonian patients},
  author={Luque-Buzo, E. and Bejani, M. and G{\'o}mez-Garc{\'\i}a, J.A. and Arias-Londo{\~n}o, J.D. and Grandas-P{\'e}rez, F. and Godino-Llorente, J.I.},
  journal={IEEE Transactions on Cognitive and Developmental Systems},
  volume = {in press},
  year={2024},
 }


```
