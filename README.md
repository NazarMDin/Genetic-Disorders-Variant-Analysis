# 🧬 Genetic Disorders Variant Analysis

**Databases used:** ClinVar · OMIM · UCSC Genome Browser  
**Classification standard:** ACMG/AMP 2015 guidelines  
**Reference genome:** GRCh38/hg38  
**Variant types covered:** Missense · Nonsense

---

## 📋 Table of Contents

- [Overview](#overview)
- [Selected Disorders](#selected-disorders)
- [Repository Structure](#repository-structure)
- [Complete Methodology](#complete-methodology)
- [ACMG/AMP Classification Summary](#acmgamp-classification-summary)
- [Software Requirements](#software-requirements)
- [Installation](#installation)
- [References](#references)

---

## Overview

This repository contains a complete variant analysis workflow for three genetic and rare disorders. For each disorder, a well-characterized pathogenic variant was selected from ClinVar and subjected to multi-database annotation, structural visualization in the UCSC Genome Browser, literature-supported functional review, and formal ACMG/AMP pathogenicity classification.

The analysis covers two variant types — missense and nonsense — across three clinically important genes, providing a comparative view of how different mutation mechanisms lead to disease.

---

## Selected Disorders

| Category | Disorder | Gene | Variant (HGVS) | Variant type |
|---|---|---|---|---|
| Genetic disorder | Sickle Cell Anemia | *HBB* | `NM_000518.5(HBB):c.20A>T (p.Glu7Val)` | Missense |
| Genetic disorder | Duchenne Muscular Dystrophy | *DMD* | `NM_004006.3(DMD):c.8713C>T (p.Arg2905Ter)` | Nonsense |
| Rare disease | Fabry Disease | *GLA* | `NM_000169.3(GLA):c.337T>C (p.Cys113Arg)` | Missense |

### Variant Highlights

**HBB c.20A>T (Sickle Cell Anemia)**  
A classic missense substitution causing glutamic acid to be replaced by valine at position 7 of the beta-globin protein. This single amino acid change causes haemoglobin to polymerise under low-oxygen conditions, deforming red blood cells into the characteristic sickle shape. One of the most studied variants in human genetics.

**DMD c.8713C>T (Duchenne Muscular Dystrophy)**  
A nonsense variant introducing a premature stop codon (p.Arg2905Ter) in the dystrophin gene — the largest gene in the human genome. Loss of dystrophin disrupts the structural link between the cytoskeleton and extracellular matrix in muscle fibres, leading to progressive muscle degeneration. X-linked recessive inheritance.

**GLA c.337T>C (Fabry Disease)**  
A missense substitution replacing cysteine with arginine at position 113 of alpha-galactosidase A, disrupting a conserved disulfide bond critical for enzyme stability. Loss of GLA activity causes glycosphingolipid accumulation in lysosomes across multiple organ systems, leading to the multi-system phenotype of Fabry disease. X-linked inheritance.

---

## Repository Structure

```
genetic-disorders-variant-analysis/
├── README.md
├── data/
│   ├── variant_analysis.xlsx        ← Complete analysis table with ACMG evidence, OMIM phenotypes, literature summaries
│   ├── variants_raw.vcf             ← Manually curated VCF (GRCh38 coordinates, all three variants)
│   └── variants_annotated.vcf       ← ClinVar-annotated VCF via BCFtools
├── screenshots/
│   ├── HBB_alphamissense_revel.png  ← UCSC Browser: AlphaMissense + REVEL tracks for HBB variant
│   ├── GLA_alphamissense_revel.png  ← UCSC Browser: AlphaMissense + REVEL tracks for GLA variant
│   └── DMD_ucsc_region.png          ← UCSC Browser: genomic region view for DMD variant (no missense tracks)
└── script/
    └── annotate_vcf.sh              ← BCFtools/VEP annotation script
```

> **Note on UCSC tracks:** AlphaMissense and REVEL scores are only applicable to missense variants. The DMD variant is a nonsense mutation and therefore does not have AlphaMissense/REVEL tracks — the UCSC screenshot for DMD shows the genomic region context only.

---

## Complete Methodology

### Step 1 — Variant selection from ClinVar

Three well-characterized pathogenic variants were selected from the ClinVar database with the following criteria:
- Clinical significance: **Pathogenic** with at least two-star review status
- Variant diversity: at least two different variant consequence types (missense and nonsense)
- Disease diversity: spanning both common genetic disorders and rare diseases
- Literature support: substantial published functional and clinical evidence

### Step 2 — Literature review and functional evidence

PubMed citations were retrieved for each variant. The review covered:
- Functional studies (protein structure, enzyme activity, in vitro/in vivo models)
- Population genetics (allele frequency in gnomAD, founder effects)
- Clinical observations (phenotype spectrum, genotype-phenotype correlations)

Key findings were summarised in the `explanation` field of the Excel analysis file.

### Step 3 — OMIM phenotype analysis

Each disorder was accessed in OMIM to extract:
- Full phenotype description and MIM number
- Inheritance pattern (autosomal recessive, X-linked recessive)
- Age of onset and clinical features
- Known allelic variants and phenotypic heterogeneity

### Step 4 — UCSC Genome Browser visualisation

For each variant, the UCSC Genome Browser (GRCh38/hg38) was used to:
1. Navigate to the variant coordinate
2. Enable the **AlphaMissense** track (deep learning-based missense pathogenicity predictions from Google DeepMind)
3. Enable the **REVEL** track (ensemble missense pathogenicity score)
4. Capture screenshots showing the track scores in genomic context

AlphaMissense and REVEL are only applicable to missense variants — scores were captured for *HBB* and *GLA*. The *DMD* nonsense variant screenshot shows the genomic region context without these tracks.

### Step 5 — ACMG/AMP variant classification

Variants were classified according to the **ACMG/AMP 2015 guidelines** (Richards et al., *Genetics in Medicine*, 2015). Evidence codes were applied and documented with detailed rationale in the Excel file.

See the [ACMG/AMP Classification Summary](#acmgamp-classification-summary) section below for a complete breakdown.

### Step 6 — VCF file creation and annotation

A VCF file was manually created with proper GRCh38 coordinates for all three variants, including standard FORMAT fields. The file was then annotated against the ClinVar database using BCFtools:

```bash
bcftools annotate \
  -a clinvar_GRCh38.vcf.gz \
  -c CLNSIG,CLNDN,CLNREVSTAT \
  -o variants_annotated.vcf \
  variants_raw.vcf
```

Annotations were verified against known ClinVar classifications to confirm concordance.

### Step 7 — Repository organisation

Files were structured following standard bioinformatics project conventions, with raw data, processed outputs, screenshots, and scripts kept in separate subdirectories.

---

## ACMG/AMP Classification Summary

All three variants were classified as **Pathogenic**.

### HBB c.20A>T — Sickle Cell Anemia

| Evidence code | Category | Rationale |
|---|---|---|
| PS1 | Strong pathogenic | Same amino acid change as established pathogenic variant |
| PM1 | Moderate pathogenic | Located in critical functional domain of beta-globin |
| PM2 | Moderate pathogenic | Absent from gnomAD general population (homozygous state) |
| PP3 | Supporting pathogenic | Multiple in silico tools predict deleterious effect |
| PP5 | Supporting pathogenic | Classified Pathogenic in ClinVar with expert review |

**Final classification: Pathogenic**

### DMD c.8713C>T — Duchenne Muscular Dystrophy

| Evidence code | Category | Rationale |
|---|---|---|
| PVS1 | Very strong pathogenic | Nonsense variant predicted to cause loss of function in a gene where LOF is a known disease mechanism |
| PM2 | Moderate pathogenic | Absent or extremely rare in gnomAD |
| PM3 | Moderate pathogenic | Detected in trans with another pathogenic variant |
| PP4 | Supporting pathogenic | Patient phenotype highly specific for DMD |
| PP5 | Supporting pathogenic | Classified Pathogenic in ClinVar with expert review |

**Final classification: Pathogenic**

### GLA c.337T>C — Fabry Disease

| Evidence code | Category | Rationale |
|---|---|---|
| PS1 | Strong pathogenic | Same amino acid change as established pathogenic variant |
| PS3 | Strong pathogenic | Functional studies show significantly reduced enzyme activity |
| PM1 | Moderate pathogenic | Located in critical active site / disulfide bond region |
| PM2 | Moderate pathogenic | Absent from gnomAD controls |
| PM5 | Moderate pathogenic | Novel missense at same position as known pathogenic variant |
| PP3 | Supporting pathogenic | AlphaMissense, REVEL, and CADD predict deleterious effect |

**Final classification: Pathogenic**

---

## Software Requirements

| Tool | Version | Purpose |
|---|---|---|
| Python | ≥ 3.8 | Data processing and scripting |
| BCFtools | ≥ 1.9 | VCF manipulation and ClinVar annotation |
| Ensembl VEP | Latest | Functional variant annotation |
| samtools / htslib | ≥ 1.9 | BAM/VCF indexing and manipulation |
| pandas | Latest | Tabular data handling |
| numpy | Latest | Numerical operations |
| matplotlib | Latest | Plotting |
| Web browser | Latest | UCSC Genome Browser access |

---

## Installation

### 1. Create and activate a conda environment

```bash
conda create -n variant_analysis python=3.8
conda activate variant_analysis
```

### 2. Install bioinformatics tools

```bash
conda install -c bioconda bcftools samtools htslib
conda install -c bioconda ensembl-vep
```

### 3. Install Python dependencies

```bash
pip install pandas numpy matplotlib
```

### 4. Download ClinVar VCF for annotation (GRCh38)

```bash
wget https://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh38/clinvar.vcf.gz
wget https://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh38/clinvar.vcf.gz.tbi
```

### 5. Run the annotation script

```bash
chmod +x script/annotate_vcf.sh
./script/annotate_vcf.sh
```

---

## References

- Richards, S. et al. (2015). Standards and guidelines for the interpretation of sequence variants. *Genetics in Medicine*, 17(5), 405–424. *(ACMG/AMP guidelines)*
- Landrum, M.J. et al. (2016). ClinVar: public archive of interpretations of clinically relevant variants. *Nucleic Acids Research*, 44(D1), D862–868.
- Ingram, V.M. (1956). A specific chemical difference between the globins of normal human and sickle-cell anaemia haemoglobin. *Nature*, 178, 792–794. *(HBB p.Glu7Val)*
- Cheng, X. et al. (2023). Accurate proteome-wide missense variant effect prediction with AlphaMissense. *Science*, 381, eadg7492.
- Ioannidis, N.M. et al. (2016). REVEL: An ensemble method for predicting the pathogenicity of rare missense variants. *American Journal of Human Genetics*, 99(4), 877–885.
- Emery, A.E.H. (2002). The muscular dystrophies. *The Lancet*, 359(9307), 687–695. *(DMD)*
- Mehta, A. et al. (2010). Fabry disease: a review of current management strategies. *QJM: An International Journal of Medicine*, 103(9), 641–659. *(GLA)*
- OMIM. Online Mendelian Inheritance in Man. Johns Hopkins University. https://omim.org
- UCSC Genome Browser. University of California Santa Cruz. https://genome.ucsc.edu
