# Advanced Computational Biology: Genetic Disorders Variant Analysis

## Assignment Overview
This repository contains the complete solution for analyzing three genetic disorders/rare diseases using ClinVar, OMIM, UCSC Genome Browser, and ACMG/AMP guidelines.

## Selected Disorders
| Category | Disorder | Gene | Variant | Variant Type |
|----------|----------|------|---------|--------------|
| Genetic Disorder | Sickle Cell Anemia | HBB | NM_000518.5(HBB):c.20A>T (p.Glu7Val) | Missense |
| Genetic Disorder | Duchenne Muscular Dystrophy | DMD | NM_004006.3(DMD):c.8713C>T (p.Arg2905Ter) | Nonsense |
| Rare Disease | Fabry Disease | GLA | NM_000169.3(GLA):c.337T>C (p.Cys113Arg) | Missense |

## Repository Contents
| Directory | Contents |
|-----------|----------|
| `data/` | Excel sheet with complete variant analysis, VCF files (raw and annotated) |
| `screenshots/` | UCSC Genome Browser captures (AlphaMissense and RAVEL tracks) |
| `docs/` | Detailed documentation of OMIM phenotypes, ACMG classifications, and variant studies |
| `scripts/` | Analysis scripts for VCF annotation and data processing |
| `references/` | Supporting reference materials (ACMG guidelines, ClinVar summaries) |

## Complete Methodology

### Step 1: Variant Selection from ClinVar
- Selected three well-characterized pathogenic variants from ClinVar
- Verified clinical significance and review status [citation:1][citation:7]
- Ensured representation of different variant types (missense, nonsense)

### Step 2: Literature Review and Variant Studies
- Reviewed PubMed citations for each variant
- Documented functional studies, population genetics, and clinical observations
- Summarized key findings in Excel "explanation" field [citation:1][citation:8]

### Step 3: OMIM Phenotype Analysis
- Accessed OMIM database for each disorder
- Extracted comprehensive phenotype descriptions
- Documented inheritance patterns, age of onset, and clinical features [citation:3][citation:4]

### Step 4: UCSC Genome Browser Analysis
- Navigated to GRCh38/hg38 coordinates for each variant
- Enabled AlphaMissense and RAVEL tracks
- Captured screenshots showing pathogenicity scores [citation:8]
- *Note: AlphaMissense/RAVEL only applicable to missense variants (HBB, GLA)*

### Step 5: ACMG/AMP Classification
- Applied ACMG/AMP 2015 guidelines [citation:6]
- For DMD nonsense variant: PVS1, PM2, PM3, PP4, PP5 [citation:1][citation:7]
- For GLA missense variant: PS1, PM1, PM2, PM5, PS3, PP3 [citation:8]
- Documented evidence codes with detailed rationale

### Step 6: VCF File Creation and Annotation
- Created properly formatted VCF file (GRCh38 coordinates)
- Included all three variants with proper FORMAT fields
- Annotated using ClinVar database via BCFtools/VEP
- Verified annotations against known classifications

### Step 7: GitHub Repository Setup
- Organized files following standard bioinformatics project structure
- Comprehensive documentation with step-by-step reproducibility guide
- Included all supporting materials and references

## Software Requirements and Dependencies
| Tool | Version | Purpose |
|------|---------|---------|
| Python | ≥3.8 | Data processing |
| BCFtools | ≥1.9 | VCF manipulation and annotation |
| VEP (optional) | ≥105 | Variant annotation |
| Web browser | Latest | UCSC Genome Browser access |

### Installation Commands
```bash
# Create conda environment
conda create -n acb_analysis python=3.8
conda activate acb_analysis

# Install required tools
conda install -c bioconda bcftools samtools htslib
conda install -c bioconda ensembl-vep
pip install pandas numpy matplotlib
