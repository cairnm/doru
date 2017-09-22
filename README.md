# doru
R script for generating a hierarchical cluster dendrogram from STR data.

Expects a .csv formated such that the six columns are:
  - hap_cluster (a manual subgrouping designation, may be arbitrary, 
                 not used in cluster calculation and intended to be
                 filled *after* cluster modeling)
  - Kit.Number (Usually FTDNA's kit ID number)
  - Name (surname)
  - Paternal.Ancestor.Name
  - Country
  - County
  - Parish
  - Lat
  - Long
  - Haplogroup (terminal SNP as designated by FTDNA, often an estimate)

The remaining columns should be the STR data, typically in FTDNA order.

This will output a hierarchical cluster dendrogram as a 8-inch by 22-inch PDF with
the concatenated Kit.Number, Name, and Haplogroup as the leaf labels.

The script uses only the first 37 markers of STR data and ignores any kits that don't
have data for at least 37 markers, but the script is documented there variables can
be changed to instead use 67 markers or 111 markers.
