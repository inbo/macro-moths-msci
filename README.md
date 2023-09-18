<!-- badges: start -->
![GitHub](https://img.shields.io/github/license/inbo/macro-moths-msci)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/inbo/macro-moths-msci/check-project)
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

## Description
<!-- description: start -->
Investigation of species traits as a guidance for moth conservation in the highly anthropogenic European region of Flanders based on multi-species change indices.
<!-- description: end -->

## Order of execution

Follow the steps below to run the scripts in the correct order:

### Step 1: data_preparation.Rmd

> You can only run this script if you have the raw data at your disposal. If not, you can skip this step.

Create a folder `data/raw` where you store the raw data.
By running this script, you will merge the raw datasets in a single intermediate dataset.
This dataset is then stored in `data/intermediate` which is created as well in the script.

### Step 2: data_exploration.Rmd

> You can skip any previous steps if desired, this script will create the necessary folders and download the necessary data from zenodo for all further analyses.

In this script, the data exploration is performed.
In the end, a final dataset is written out for further analyses.
This dataset is then stored in `data/processed` which is created as well in the script.

### Step 3: model_specification_msci.Rmd

> You can skip any previous steps if desired, this script will create the necessary folders and download the necessary data from zenodo for all further analyses.

Test script for model specification, model fit and figure creation.

### Step 4: calculate_msci_traits.Rmd

> You can skip any previous steps if desired, this script will create the necessary folders and download the necessary data from zenodo for all further analyses.

In this script, all models are fitted for the calculation of MSCIs.
In the end, a summary table is written out as well as an R object used to create figures in step 6.
The script creates the folder `output` to store these if it does not yet exists.

### Step 5: calculate_sci_species.Rmd

> You can skip any previous steps if desired, this script will create the necessary folders and download the necessary data from zenodo for all further analyses.

In this script, the model is fitted for the calculation of SCIs.
In the end, a summary table is written out.
The script creates the folder `output` to store this if it does not yet exists.

### Step 6: create_figures.Rmd

> You can skip any previous steps if desired, this script will create the necessary folders and download the necessary data from zenodo for all further analyses.

In this script, final figures are created to be used in the conference and the research paper.
The script creates the folder `media` to store these if it does not yet exists.


## Repo structure

```bash
├── .github                        │ 
│   ├── workflows                  │ 
│   │   └── checklist_project.yml  ├ GitHub repo settings
│   ├── CODE_OF_CONDUCT.md         │ 
│   └── CONTRIBUTING.md            │
├── data
│   ├── raw                        ├ create this folder and store raw data when at your disposal
│   ├── intermediate               ├ will be created 
│   └── processed                  ├
├── inst
│   └── en_gb.dic                  ├ dictionary with words that should not be checked
├── media                          ├ folder to store media
├── output                         ├ folder to store outputs
├── source
│   ├── ...                        ├ markdown and R files
│   └── brms_cache                 ├ store brms models 
│       └── ...                    │
├── checklist.yml                  ├ options checklist package (https://github.com/inbo/checklist)
├── macro-moths-msci.Rproj         ├ R project
├── README.md                      ├ project description
├── LICENSE.md                     ├ licence
├── CITATION.cff                   ├ citation info
├── .zenodo.json                   ├ zenodo metadata
└── .gitignore                     ├ files to ignore
```
