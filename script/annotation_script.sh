# Download ClinVar VCF (GRCh38)
wget ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh38/clinvar.vcf.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh38/clinvar.vcf.gz.tbi

#zip
bgzip -c patient_variants_final.vcf > patient_variants_final.vcf.gz

# Index the ClinVar VCF
tabix -p vcf clinvar.vcf.gz

# Annotate your VCF
bcftools annotate -a clinvar.vcf.gz \
  -c CLNSIG,CLNREVSTAT,CLNDN \
  patient_variants_final.vcf.gz \
  -o annotated_variants_final.vcf