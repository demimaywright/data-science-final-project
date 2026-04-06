library(ggdag)
library(dagitty)
library(tidyverse)

# The final DAG with all confounders included

my_dag <- dagify(
  
  allele_inherited ~ cas9_tagging,
  allele_inherited ~ promoter,
  allele_inherited ~ generation,
  
  # Adding the relationships between the confounders
  cas9_tagging ~~ promoter,
  cas9_tagging ~~ generation,
  
  # Label exposure and outcome
  exposure = "cas9_tagging",
  outcome = "allele_inherited",
  
  # Assigning full labels for the plot
  labels = c(
    cas9_tagging = "Cas9 Protein Tagging",
    allele_inherited = "Allele Inherited",
    promoter = "Promoter",
    generation = "Generation"
  )
)

ggdag_status(secondary_dag, use_labels = "label", text = FALSE) +
  theme_dag() +
  theme(legend.position = "bottom") +
  labs(title = "Causal DAG for Cas9 Tagging Inheritance")
