import pandas as pd
data = pd.io.stata.read_stata("../nottingham_replication_2023/replication_package/dataset.dta")
data.to_csv("../nottingham_replication_2023/replication_package/dataset.csv")
