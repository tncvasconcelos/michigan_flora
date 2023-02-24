
library(ape)

full_tree <- read.tree("trees/GBMB.tre")
full_tree$tip.label <- gsub("_", " ", full_tree$tip.label)

MI_species <- read.csv("michigan_flora_scrape_names.1.10.23.txt", h=F, sep = "\t")
#MI_species_list <- MI_species$V2

rosaceae_sp_list <- subset(MI_species, MI_species$V1=="Rosaceae")
rosaceae_tips <- rosaceae_sp_list$V2[which(rosaceae_sp_list$V2 %in% full_tree$tip.label)]
rosaceae_tree <- keep.tip(full_tree, rosaceae_tips)
rosaceae_tree$node.label <- NULL

plot(rosaceae_tree, cex=0.5)
axisPhylo()

####
onagraceae_sp_list <- subset(MI_species, MI_species$V1=="Onagraceae")
onagraceae_tips <- onagraceae_sp_list$V2[which(onagraceae_sp_list$V2 %in% full_tree$tip.label)]
onagraceae_tree <- keep.tip(full_tree, onagraceae_tips)
onagraceae_tree$node.label <- NULL

plot(onagraceae_tree, cex=0.5)
axisPhylo()

#####
alternative_onagraceae_tree <- read.tree("trees/Onagraceae-Freyman_&_Hohna-2018_cleaned.tre")
alternative_onagraceae_tree$tip.label <- gsub("_", " ", alternative_onagraceae_tree$tip.label)
alternative_onagraceae_tree$root.edge <- NULL

onagraceae_sp_list <- subset(MI_species, MI_species$V1=="Onagraceae")
onagraceae_tips <- onagraceae_sp_list$V2[which(onagraceae_sp_list$V2 %in% alternative_onagraceae_tree$tip.label)]
onagraceae_tree <- keep.tip(alternative_onagraceae_tree, onagraceae_tips)

plot(onagraceae_tree, cex=0.5)
axisPhylo()

#####
alternative_rosaceae_tree <- read.tree("trees/Rosaceae_tree_Sun_etal_2020.tre.txt")
alternative_rosaceae_tree$tip.label <- gsub("_", " ", alternative_rosaceae_tree$tip.label)

rosaceae_sp_list <- subset(MI_species, MI_species$V1=="Rosaceae")
rosaceae_tips <- rosaceae_sp_list$V2[which(rosaceae_sp_list$V2 %in% alternative_rosaceae_tree$tip.label)]
rosaceae_tree <- keep.tip(alternative_rosaceae_tree, rosaceae_tips)

rosaceae_tree <- ladderize(rosaceae_tree)
plot(rosaceae_tree, cex=0.5)
axisPhylo()






