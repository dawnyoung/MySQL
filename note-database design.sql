/*
#############################################################
                       Database
#############################################################


############Normalization
- reduce storage requirements
- increase database efficiency

# First normal form (1NF)
- designing a table for each set of related attributes giving 
  each table a primary key.
- eliminate duplicate columns from the same table


# Second normal form (2NF)
- create tables for subsets of data that apply to multiple rows
- create relationships between the newly created tables
- remove partial dependencies
- process: write each key on a separate line
           correspond dependent attributes to the key
           assign names of tables

# Third normal form (3NF)
- remove any columns from a table that are not dependent on the
  primary key
- in practice, 3NF is sufficient for database normalization

# Boyce-codd normal form
- used for special 3NF
- every determinant in the table is a candidate key

# Fourth normal form (4NF)
- dose not contain any multivalued dependencies

*/