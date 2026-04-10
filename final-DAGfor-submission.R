library(ggdag)
library(dagitty)
library(tidyverse)

# The final DAG with all confounders included
# question 4

final_assignment_dag <- dagify(
  
  cas9_tagging ~ promoter,
  allele_inherited ~ promoter, # This is the confounder that affects both the exposure and the outcome
  allele_inherited ~ cas9_tagging,
  allele_inherited ~ generation,
  allele_inherited ~ transgenic_line,
  
  exposure = "cas9_tagging",
  outcome = "allele_inherited",
  
  labels = c(
    cas9_tagging = "Cas9 Protein Tagging",
    allele_inherited = "Allele Inherited",
    promoter = "Promoter",
    generation = "Generation",
    transgenic_line = "Transgenic Line"
  )
)

ggdag_status(final_assignment_dag, use_labels = "label", text = FALSE) +
  theme_dag() +
  theme(legend.position = "bottom") +
  labs(title = "Causal DAG for Cas9 Tagging Inheritance")

# checking for colliders
# question 6

ggdag_collider(final_assignment_dag) + 
  theme_dag() +
  theme(legend.position = "bottom") +
  labs(title = "Collider Check",
       subtitle = "Variables with arrows pointing into them")



