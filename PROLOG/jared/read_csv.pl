:- csv_read_file('../../Datasets/cube/0_file.csv',Rows,[functor(table)]),
maplist(assert,Rows).