# install dependancies 
install.packages("readxl")
library(readxl)
install.packages("dplyr")
library(dplyr)

# read_excel reads xls and assign data frames 
GlycoMod_opt <- read_xlsx("E:/MECFS_Biomarkers/MECFS_Nglycans/GlycoMod_NG_Glycoconnect_list.xlsx", sheet = 1)

# remove glycans with no (HexNAc)2 or (GlcNAc)2 that correlates to a N-glycan core 
NG_list <- GlycoMod_opt %>% filter(real != "n")
write.csv(NG_list, "Prelim_NG_list.csv")

# figure out possibe precurrsour ions of -1, -2, -3 charges states 
# add or subtract delta mass from the glyco form masses 
is.numeric(NG_list$`Delta mass (Dalton)`)
sign(NG_list$`Delta mass (Dalton)`)


# minus the Reduced reducing end 
for ( i in NG_list)
  
{
  DerMass <- c(NG_list$`glycoform mass` - 20.0261946 )
}
NG_list$DerMass <-DerMass

# minus hydrogen ions and divide for  charge states -1, -2, -3
for (i in NG_list) {
  Ion1 <- c(NG_list$DerMass / 1 - 1.00727)
  Ion2 <- c(NG_list$DerMass / 2 - 1.00727)
  Ion3 <- c(NG_list$DerMass / 3 - 1.00727)
}
NG_Ions <- NG_list
NG_Ions$Ion1 <- Ion1
NG_Ions$Ion2 <- Ion2
NG_Ions$Ion3 <- Ion3

# import peak lists to match glycan ions to
M15 <- read_xls("E:/MECFS_Biomarkers/MECFS_Nglycans/MS2ScanRawMeat.xls", sheet = 1)
M12 <- read_xls("E:/MECFS_Biomarkers/MECFS_Nglycans/MS2ScanRawMeat.xls", sheet = 2)
M11 <- read_xls("E:/MECFS_Biomarkers/MECFS_Nglycans/MS2ScanRawMeat.xls", sheet = 3)
M10 <- read_xls("E:/MECFS_Biomarkers/MECFS_Nglycans/MS2ScanRawMeat.xls", sheet = 4)
M1 <- read_xls("E:/MECFS_Biomarkers/MECFS_Nglycans/MS2ScanRawMeat.xls", sheet = 5)
HC25 <- read_xls("E:/MECFS_Biomarkers/MECFS_Nglycans/MS2ScanRawMeat.xls", sheet = 6)
HC22 <- read_xls("E:/MECFS_Biomarkers/MECFS_Nglycans/MS2ScanRawMeat.xls", sheet = 7)
HC20 <- read_xls("E:/MECFS_Biomarkers/MECFS_Nglycans/MS2ScanRawMeat.xls", sheet = 8)
HC14 <- read_xls("E:/MECFS_Biomarkers/MECFS_Nglycans/MS2ScanRawMeat.xls", sheet = 9)
HC13 <- read_xls("E:/MECFS_Biomarkers/MECFS_Nglycans/MS2ScanRawMeat.xls", sheet = 10)

# remove scans with a chare state of 0
HC13_chag <- HC13 %>% filter(Charge != "0")
HC14_chag <- HC14 %>% filter(Charge != "0")
HC20_chag <- HC20 %>% filter(Charge != "0")
HC22_chag <- HC22 %>% filter(Charge != "0")
HC25_chag <- HC25 %>% filter(Charge != "0")
M1_chag <- M1 %>% filter(Charge != "0")
M10_chag <- M10 %>% filter(Charge != "0")
M11_chag <- M11 %>% filter(Charge != "0")
M12_chag <- M12 %>% filter(Charge != "0")
M15_chag <- M15 %>% filter(Charge != "0")

# for each ion find matches within a 0.5Da tollerence 
if match()