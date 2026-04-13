library(ggdag)
library(dagitty)
library(tidyverse)

# The final DAG with all confounders included
# question 4
final_assignment_dag <- dagify(
  cas9_activity ~ cas9_tagging, 
  cas9_activity ~ promoter, 
  allele_inherited ~ generation,
  allele_inherited ~ transgenic_line,
  allele_inherited ~ cas9_activity, 
  
  exposure = "cas9_tagging",
  outcome = "allele_inherited",
  latent = "cas9_activity", 
  
  labels = c(
    cas9_tagging = "Cas9 Degron Tagg",
    allele_inherited = "Allele Inherited",
    promoter = "Promoter",
    generation = "Generation",
    transgenic_line = "Transgenic Line",
    cas9_activity = "Cas9 Activity"
  )
)

# Plotting with ggdag_status will automatically distinguish the latent node
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




