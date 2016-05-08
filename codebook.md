Global param
------------
-  WorkingDirectory	(char)
-  DownloadDirectory	(char)
-  DownloadFileName	(char)
-  dataDirectory		(char)
-  urlDataSet        	(char)
-  v1			(vector)

App param
---------
 - FileLocation
 - VP (vector) with generated filepaths
 - Mx (data frame) merged train en test x
 - My (data frame) merged train en test y
 - Ms (data frame) merged train en test subject
 - Mf (data frame) loaded features
 - Ma (data frame) activity_labels
 - Ds (data frame) dataset
 - CleanDs (data frame) clean dataset
 - TidyData (data frame) ready for export .txt


Output TidyData
---------------
- Subject (first column)
- Type : int
- Example (1,1,1,2,2,2,2,3,3 ....)

- Activity  (second column)
- Type : char
- Example (LAYING,SITTING,STANDING,STANDING ....)

- The other columns in the tidydata are integers, they can be positiv or negativ values (column 3t/m 66)
- Example (0.22159824394 -0.0405139534294 -0.11320355358 -0.9280564692 -0.83682740562 ...)

