<!-- badges: start -->
![GitHub](https://img.shields.io/github/license/inbo/macro-moths-msci)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/inbo/macro-moths-msci/check-project)
![GitHub repo size](https://img.shields.io/github/repo-size/inbo/macro-moths-msci)
<!-- badges: end -->

# Macro-moth trends in Flanders

[Maes, Dirk![ORCID logo](https://info.orcid.org/wp-content/uploads/2019/11/orcid_16x16.png)](https://orcid.org/https://orcid.org/0000-0002-7947-3788)[^aut][^cre][^INBO]
[Langeraert, Ward![ORCID logo](https://info.orcid.org/wp-content/uploads/2019/11/orcid_16x16.png)](https://orcid.org/https://orcid.org/0000-0002-5900-8109)[^aut][^cre2][^INBO]
Research Institute for Nature and Forest (INBO)[^cph][^fnd]

[^cph]: copyright holder
[^fnd]: funder
[^aut]: author
[^cre]: contact person
[^cre2]: contact person GitHub repo
[^INBO]: Research Institute for Nature and Forest (INBO), Herman Teirlinckgebouw, Havenlaan 88 PO Box 73, B-1000 Brussels, Belgium

**keywords**: macro-moths; Flanders; species change index; multi-species index; traits; pollinators; conservation; threatened species

<!-- community: inbo -->

<!-- description: start -->
Investigation of species traits as a guidance for moth conservation in the highly anthropogenic European region of Flanders based on multi-species change indices.
<!-- description: end -->

**Repo structure**:

```bash
├── .github                        │ 
│   ├── workflows                  │ 
│   │   └── checklist_project.yml  ├ GitHub repo settings
│   ├── CODE_OF_CONDUCT.md         │ 
│   └── CONTRIBUTING.md            │
├── data
│   ├── raw                        │
│   ├── intermediate               ├ data files (*.csv)
│   └── processed                  │
├── inst
│   └── en_gb.dic                  ├ dictionary with words that should not be checked
├── media                          ├ folder to store media
├── output                         ├ folder to store outputs
├── source
│   ├── brms_cache                 ├ store brms models 
│   │   └── ...                    │
│   ├── ...                        ├ markdown and R files
│   └── references.json            ├ references markdown files
├── checklist.yml                  ├ options checklist package (https://github.com/inbo/checklist)
├── LICENSE.md                     ├ licence
├── macro-moths-msci.Rproj         ├ R project
├── README.md                      ├ project description
└── .gitignore                     ├ files to ignore
```
