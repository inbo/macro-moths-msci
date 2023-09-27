<!-- badges: start -->
![GitHub](https://img.shields.io/github/license/inbo/macro-moths-msci)
[![Release](https://img.shields.io/github/release/inbo/macro-moths-msci.svg)](https://github.com/inbo/macro-moths-msci/releases)
![GitHub repo size](https://img.shields.io/github/repo-size/inbo/macro-moths-msci)
<!-- badges: end -->

# Moth trends and traits in Flanders (northern Belgium)

[Langeraert, Ward![ORCID logo](https://info.orcid.org/wp-content/uploads/2019/11/orcid_16x16.png)](https://orcid.org/0000-0002-5900-8109)[^aut][^cre][^INBO]
[Maes, Dirk![ORCID logo](https://info.orcid.org/wp-content/uploads/2019/11/orcid_16x16.png)](https://orcid.org/0000-0002-7947-3788)[^aut][^INBO]
Research Institute for Nature and Forest (INBO)[^cph][^fnd]

[^cph]: copyright holder
[^fnd]: funder
[^aut]: author
[^cre]: contact person
[^INBO]: Research Institute for Nature and Forest (INBO), Herman Teirlinckgebouw, Havenlaan 88 PO Box 73, B-1000 Brussels, Belgium

**keywords**: moths; Flanders; species change index; multi-species index; traits; pollinators; conservation; threatened species

<!-- community: inbo -->

### Description
<!-- description: start -->
Investigation of species traits as a guidance for moth conservation in the highly anthropogenic European region of Flanders based on multi-species change indices.
<!-- description: end -->

### Order of execution

Follow the steps below to run the scripts in a logical order.
You can skip any steps if desired, each script will create the necessary folders and download the necessary data from zenodo each time if required.
Open the R project file `macro-moths-msci.Rproj` before opening any scripts such that the relative paths in the scripts work properly.

#### Step 1: data_preparation.Rmd

> You can only run this script if you have the raw data at your disposal. If not, you can skip this step.

Create a folder `data/raw` where you store the raw data.
By running this script, you will merge the raw datasets in a single intermediate dataset.
This dataset is then stored in `data/intermediate` which is created by the script if it does not exist yet.

#### Step 2: data_exploration.Rmd

In this script, data exploration is performed.
In the end, a final dataset is written out for further analyses.
This dataset is then stored in `data/processed` which is created by the script if it does not exist yet.

#### Step 3: model_specification_msci.Rmd

Test script for model specification, model fit and figure creation.

#### Step 4: calculate_msci_traits.Rmd

In this script, all models are fitted for the calculation of MSCIs.
Models are cached in the folder `source/brms_cache` which is created in the script if it does not exist yet.
In the end, a summary table is written out as well as an R object used to create figures in step 6.
The script creates the folder `output` to store these if it does not exist yet.

#### Step 5: calculate_sci_species.Rmd

In this script, the model is fitted for the calculation of SCIs.
Model is cached in the folder `source/brms_cache` which is created in the script if it does not exist yet.
In the end, a summary table is written out.
The script creates the folder `output` to store this if it does not exist yet.

#### Step 6: create_figures.Rmd

In this script, final figures are created to be used in the conference and the research paper.
The script creates the folder `media` to store these if it does not exist yet.


### Repo structure

```bash
├── source
│   ├── ...                        ├ markdown and R files (see order of execution)
│   └── brms_cache                 ├ store brms models (see order of execution)
│       └── ...                    │
├── data
│   ├── raw                        ├ create this folder and store raw data if at your disposal
│   ├── intermediate               ├ will be created in step 1 or 2 (see order of execution)
│   └── processed                  ├ will be created in step 2, 3, 4 or 5 (see order of execution)
├── output                         ├ folder to store outputs (will be created in step 4, 5 or 6)
├── media                          ├ folder to store media (will be created in step 6)
├── checklist.yml                  ├ options checklist package (https://github.com/inbo/checklist)
├── inst
│   └── en_gb.dic                  ├ dictionary with words that should not be checked by the checklist package
├── .github                        │ 
│   ├── workflows                  │ 
│   │   └── checklist_project.yml  ├ GitHub repo settings
│   ├── CODE_OF_CONDUCT.md         │ 
│   └── CONTRIBUTING.md            │
├── macro-moths-msci.Rproj         ├ R project
├── README.md                      ├ project description
├── LICENSE.md                     ├ licence
├── CITATION.cff                   ├ citation info
├── .zenodo.json                   ├ zenodo metadata
└── .gitignore                     ├ files to ignore
```
