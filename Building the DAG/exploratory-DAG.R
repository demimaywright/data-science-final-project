
library(ggdag)
library(dagitty)
library(tidyverse)

## Initial DAG based on assumptions about the relationships between variables in the experiment.

putative_dag <- dagify(
  
  allele_inherited ~ cas9_tagging,
  allele_inherited ~ promoter,
  allele_inherited ~ generation,
  
  # Label which is exposure and outcome
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

ggdag_status(putative_dag, use_labels = "label", text = FALSE) +
  theme_dag() +
  theme(legend.position = "bottom") +
  labs(title = "Causal DAG for Cas9 Tagging")

# However I disagree when looking at it, as I think its deeper than that:  
  # Cas9 tagging has a greater effect on generation 1 than 0 as there are more opportunities for maternal deposition 
  # and accumulation of Gene Drive Indels, the degron tagged Cas9 can stop this from having such a large effect.  

# adding a relationship between the cofounders to reflect the fact that they do not act independent of each other. 

secondary_dag <- dagify(
  
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



  