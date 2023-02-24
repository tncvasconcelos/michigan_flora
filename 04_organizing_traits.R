
# Getting means for each species
setwd("~/Desktop/michigan_flora")
preliminary_dataset <- read.csv("trait_data/2023_02_23_rosaceae_per_specimen.csv")
species <- preliminary_dataset$Name

# What are the species in the dataset?
all_species <- unique(species)
all_species <- subset(all_species, all_species!="")
# What are the traits in the dataset?
all_traits <- c("Petiole.length..mm.","Petiolet.length..mm.","Mass.of.Leaf.Sample..g.","Petal.Length..mm.")   

all_means_tables <- list()

for(trait_index in 1:length(all_traits)) {
  one_means_table <- as.data.frame(matrix(nrow=length(all_species), ncol=3))
  for(species_index in 1:length(all_species)) {
    one_subset <- subset(preliminary_dataset, preliminary_dataset$Name==all_species[species_index])
    one_means_table$V1[species_index] <- all_species[species_index]
    values <- one_subset[,all_traits[trait_index]]
    values <- subset(values, !is.na(one_subset[,all_traits[trait_index]]))
    one_means_table$V2[species_index] <- mean(as.numeric(values))
    one_means_table$V3[species_index] <- sd(as.numeric(values))
  }
  all_means_tables[[trait_index]] <- one_means_table
  names(all_means_tables)[trait_index] <- all_traits[trait_index]
}

do.call(cbind, all_means_tables)
