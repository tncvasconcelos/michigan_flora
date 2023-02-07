# Load required packages:
library(BIEN)
library(ggplot2)

setwd("~/Desktop/michigan_flora")
species_list <- read.csv("michigan_flora_scrape_names.1.10.23.txt", h=F, sep = "\t")
colnames(species_list) <- c("Family", "Species")

####
# Making simple plots for diversity of species and genera
t0 <- table(species_list$Family)
t0_sorted <- sort(t0, decreasing=T)[1:50]
par(mar = c(7, 4, 2, 2) + 0.2) # add room for rotating labels
barplot(t0_sorted,  las=2)


####
# making a "trait" datasets for species in the MI flora using BIEN
all_traits_BIEN <- BIEN_trait_list()
MI_all_traits <- BIEN_trait_species(species_list$Species)

# nrow(MI_all_traits)
# [1] 12570137

n_species <- length(species_list$Species)
all_traits <- unique(MI_all_traits$trait_name)

#results_trait_completeness <- as.data.frame(matrix(ncol=2, nrow=length(all_traits)))
results_trait_completeness <- c()
for(trait_index in 1:length(all_traits)) {
  subset0 <- subset(MI_all_traits, MI_all_traits$trait_name==all_traits[trait_index])
  proportion_complete0 <- length(unique(subset0$scrubbed_species_binomial)) / n_species
  #results_trait_completeness[trait_index,1] <- all_traits[trait_index]
  #results_trait_completeness[trait_index,2] <- proportion_complete0
  results_trait_completeness[trait_index] <- proportion_complete0
  names(results_trait_completeness)[trait_index] <- all_traits[trait_index]
}

t1_sorted <- sort(results_trait_completeness, decreasing = T)[1:25]
#par(mar = c(7, 4, 2, 2) + 5) # add room for rotating labels
#barplot(t1_sorted,  las=2)

df <- data.frame(trait=names(t1_sorted), proportion=round(t1_sorted,3))
p <- ggplot(data=df, aes(x=reorder(trait, proportion), y=proportion)) +
  geom_bar(stat="identity", fill="steelblue")+
  geom_text(aes(label=proportion), size=2.75, nudge_y=0.03)+
  theme_minimal()+ 
  ylab("proportion complete") + xlab("trait name") #+ 
#  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))


pdf("trait_prop_MIflora.pdf", height=5, width=9)
p + coord_flip()
dev.off()



subset0[subset0$scrubbed_species_binomial=="Rosa multiflora",]


