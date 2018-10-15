## From data-raw to data

### ge_imports and ge_exports
To use the same script `raw_data_transform`:

  - go to the home directory of the project (you can get it using `here::here()`)
  - run the following commands from the command line
  
      + `Rscript ./data-raw/raw_data_transform.R "data-raw/Export Country_1995-2018_eng.xlsx" "data/ge_exports.csv"`

      + `Rscript ./data-raw/raw_data_transform.R "data-raw/Import Country 1995-2018_eng.xlsx" "data/ge_imports.csv"`
