# Usage
### Prerequisites
* **MATLAB R2018b** or later
  
* **Image Processing Toolbox**
  
* Data arranged under:
```
C:\projects\placenta_topography\Data\
├── Images\
│   ├── Image_0XX.mat  % each contains mrImage & pixDim
└── Labels\
    ├── Label_0XX_placenta.mat  % contains mrLabel or plLabel
    └── Label_0XX_uterus.mat    % contains utLabel
```
### Running the Pipeline
```
dataFolder = 'C:\projects\placenta_topography\Data';
saveFolder = 'C:\projects\placenta_topography\Outputs';
run_topography(dataFolder, saveFolder, true, true);
```
  * true (3rd arg) tells it to save all maps and figures.

  * true (4th arg) enables slice-by-slice registration.

# Background & Motivation
**MRI in prenatal imaging**: MRI provides high-resolution soft-tissue contrast, increasingly used for placental assessment beyond ultrasound limitations 

* **Challenge**: The complex 3D shape of the placenta and intra-volume slice misalignment hinder direct volumetric analysis and feature extraction.

* **Objective**: Develop a geometry-invariant mapping to a 2D domain, enabling uniform feature computation across subjects and facilitating both visual inspection and downstream machine-learning tasks.

# Topographic Mapping Framework
### Polar Topographic Mapping
![image](https://github.com/user-attachments/assets/b0944550-7c1f-467e-8342-e864d1baa9d1)

* **Origin selection**: Define a Point of Observation (PO) at the centroid of either the placenta (Cₚ) or uterine cavity (Cᵤ) 

* **Polar coordinates**: For each surface point, compute azimuth (φ) and elevation (θ) angles relative to the PO, then project onto a 2D polar grid (θ vs. φ).

* **Surface partition**: Separately map fetal and maternal placental surfaces based on their hemisphere relative to the PO.

### Planar Topographic Mapping
![image](https://github.com/user-attachments/assets/65dedd8e-56ed-41d5-b351-19d252201874)

* **Orthogonal slicing**: Generate 2D maps for four planar surfaces—sagittal left/right and coronal anterior/posterior—by measuring radial distance from the PO along fixed image axes.

* **Planar scheme**: Defines coordinate axes on each plane and extracts contiguous surface strips for feature computation.

# Features Extracted
![image](https://github.com/user-attachments/assets/62b11549-e1bb-4063-9c6d-7fcf5ab54496)

![image](https://github.com/user-attachments/assets/1ca1359b-dd41-41d9-ac0a-6b021573f1c7)


### For both mapping domains, the following feature maps are computed and displayed as 2D images:

  * Distance maps: Radial distance from PO to each surface point (fetal vs. maternal sides) 

  * Thickness map: Local separation between fetal and maternal surfaces 

  * Intensity map: Voxel intensity at the surface point.

  * Local average intensity: Mean intensity over a small neighborhood around each surface point.

  * Local intensity standard deviation: Measures tissue heterogeneity.

  * Local entropy: Texture complexity indicator (higher in heterogeneous, possibly diseased tissue).

# Handling Slice Misalignment & Artifacts
![image](https://github.com/user-attachments/assets/eb7c789a-9972-4211-81e9-ebed782ce902)

* **Interpolation & registration**: Even/odd slice misalignments are corrected via slice-by-slice registration and interpolation prior to mapping.

* **Polar artifacts**: Residual intra-volume motion induces distortions at the extreme “superior” and “inferior” poles of polar maps.

# Clinical & Computational Insights
* **Visualization**: Topographic maps condense complex 3D structure into an easy-to-interpret 2D layout, highlighting regional variations in thickness, perfusion (intensity), and texture (entropy).

* **Quantitative analysis**: Enables standardized feature vectors for machine learning—e.g., predicting placenta accreta severity or need for hysterectomy.

### Comparative cases
![image](https://github.com/user-attachments/assets/9f25f0a7-1f69-4ccb-b84d-09198bb2b990)

![image](https://github.com/user-attachments/assets/a93857a9-3a28-44d4-aaf6-70d65684409b)

Normal vs. PAS: In PAS-suspected cases, maps reveal focal thickening and increased heterogeneity on the maternal side.

# Conclusions & Future Directions
* **Innovation**: First application of topographic surface analysis to placenta MRI, offering a unified 2D representation for both clinical review and computational modeling.

* **Potential applications**: Computer-assisted diagnosis of placental pathologies, risk stratification, and integration with radiomics pipelines.

* **Extensions**:

  * Automate PO selection via deep learning.

  * Incorporate other modalities (e.g., diffusion MRI) for multiparametric mapping.

  * Validate predictive power on larger, multi-center cohorts.

# Acknowledgements
This work is directly related to the paper *James Huang, Maysam Shahedi, Quyen N. Do, Yin Xi, Matthew A. Lewis, Christina L. Herrera, David Owen, Catherine Y. Spong, Ananth J. Madhuranthakam, Diane M. Twickler, Baowei Fei, "Topography-based feature extraction of the human placenta from prenatal MR images," Proc. SPIE 12464, Medical Imaging 2023: Image Processing, 1246420 (3 April 2023); doi: 10.1117/12.2653663*

**Paper**: [SPIE_2023_PlacentaTopography_Paper_Huang.pdf](https://github.com/JamesHuang404/Placenta-Topography/files/11174914/SPIE_2023_PlacentaTopography_Paper_Huang.pdf)

**Poster**: [SPIE2023_PlacentaTopography_Poster_Huang.pdf](https://github.com/JamesHuang404/Placenta-Topography/files/11174919/SPIE2023_PlacentaTopography_Poster_Huang.pdf)
