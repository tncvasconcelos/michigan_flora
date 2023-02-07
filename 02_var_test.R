
setwd("~/Desktop/michigan_flora")

petiole_test <- read.csv("petiole_test.csv")
colnames(petiole_test)[1] <- "species"
all_species <- unique(petiole_test$species)

all_tests <- as.data.frame(matrix(ncol=3, nrow=0))
for(i in 1:length(all_species)) {
  one_species <- all_species[i]  
  one_subset <- subset(petiole_test, petiole_test$species==one_species)
  collectors <- unique(one_subset$Specimen_collector)
  tests <- 1
  results <- as.data.frame(matrix(nrow=50, ncol=3))
  while(tests<=50) {
    samples_to_pick <- sample.int(7,3)
    subset_test <- subset(one_subset, one_subset$Specimen_collector%in%collectors[samples_to_pick])
    results[tests, 1] <- one_species
    results[tests, 2] <- as.numeric(median(subset_test$petiole))
    results[tests, 3] <- as.numeric(sd(subset_test$petiole))
    tests <- tests + 1
  }
  all_tests <- rbind(all_tests, results)
}


