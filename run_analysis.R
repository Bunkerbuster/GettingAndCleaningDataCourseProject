# needed packages
  library(plyr)
  library(data.table)

# param
  WorkingDirectory  <- "E:/Cousera/03 Getting and Cleaning Data/Assignment"
  DownloadDirectory <- "data"
  DownloadFileName  <- "data.zip"
  dataDirectory     <- "UCI HAR Dataset"
  urlDataSet        <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Adding vectors for creating URI
v1 <- c("train","test")


Run_Analysis <- function()
{
    # Set working Directory
    print(SetWorkDirectory(PhysicalPath = WorkingDirectory))
    
    # Set up a download location
    print(CheckDownloadDirectory(WorkingDirectory = WorkingDirectory,SubDirectory = DownloadDirectory))
   
    # Create A filelocation
    FileLocation <- file.path(DownloadDirectory,DownloadFileName)
    
    # Download the data
    print(DownloadFile(URI = urlDataSet,FileLocation = FileLocation))
  
    # Unzip Downloaded file
    print(unzipFile(FileLocation = FileLocation))

    # creating a vector with the nessecary filepath, For dimension X, Y and subject
    # In this case we will have 4 URI to the files we need, VP = a Vector with Paths
    VP <- c(
          FilePath_m(v1=v1, Dir = dataDirectory, Dimension="x")
          ,FilePath_m(v1=v1,Dir = dataDirectory,Dimension="y")
          ,FilePath_m(v1=v1,Dir = dataDirectory,Dimension="subject")
          ,file.path(dataDirectory,paste("features","txt",sep="."))
          ,file.path(dataDirectory,paste("activity_labels","txt",sep="."))
    )
  
    # dimensions of the object +Summary
    # dim(VP)
  
  # 1. Merges the training and the test sets to create one data set.
    # Merging the two files Train + test for X, Y and subject
    Mx <- rbind(LoadDataToTable(VP[1]),LoadDataToTable(VP[2]))
    My <- rbind(LoadDataToTable(VP[3]),LoadDataToTable(VP[4]))
    Ms <- rbind(LoadDataToTable(VP[5]),LoadDataToTable(VP[6]))
    Mf <- LoadDataToTable(VP[7])
    Ma <- LoadDataToTable(VP[8])
    
  
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  
    # Create a Dataset with only mean and std Form the x dimension
    # we use the names from the features.txt
    # with grep we matches substrings in strings 
    Ds <- Mx[, grep("-(mean|std)\\(\\)", Mf[, 2])]

    # dimensions of the object +Summary
    # dim(Ds)
    # summary(Ds)
  
    # Filter and replace the non readable names in the Mx datatset with the Readable names from the Mf dataset
    # we are only intereseeted in the mean and the standard deviation
    names(Ds) <- Mf[grep("-(mean|std)\\(\\)", Mf[, 2]), 2] 
    
    # dimensions of the object + view + Summary
    # dim(Ds)
    # View(Ds)
    # summary(Ds)

  # 3. Uses descriptive activity names to name the activities in the data set
    # Setting descriptive activity names to name the activities in the data set
    # We will using the y dimension for this
    My[, 1] <- Ma[My[, 1], 2]

    # setting the header for the data to activity
    names(My) <- "Activity"
    
    # dimensions of the object + view + Summary
    # dim(My)
    # View(My)
    # summary(My)
 
    
  # 4. Appropriately labels the data set with descriptive variable names. 
    names(Ms) <- "Subject"
    
    # dim(Ms)
    # View(Ms)
    # summary(Ms)
    
    # bind all the independent datasets
    CleanDs <- cbind(Ds, My, Ms)
    
    # clean up some of the names
    names(CleanDs) <- make.names(names(CleanDs))
    names(CleanDs) <- gsub("\\(\\)","",names(CleanDs))
    names(CleanDs) <- gsub("std","Std",names(CleanDs))
    names(CleanDs) <- gsub("mean","Mean",names(CleanDs))
    names(CleanDs) <- gsub("-","",names(CleanDs))
    
    # View(CleanDs)
    # dim(CleanDs)
    # summary(CleanDs)
    # names(CleanDs)
    
  # 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    TidyData <- aggregate(. ~Subject + Activity, CleanDs, mean)
    TidyData <- TidyData[order(TidyData$Subject,TidyData$Activity),]
    write.table(TidyData, file = "TidyData.txt",row.name=FALSE)
}

# Setting up workdirectory
SetWorkDirectory <- function(PhysicalPath){
  if(getwd() != PhysicalPath)
  {
    setwd(PhysicalPath)
    return("Workingdirectory set")
  }
  else
  {
    return("Workingdirectory already set")
  }
}


# To run This version you need version R 3.2.0
# This function will test if a specific subdirectory exist, if it doesn't it will create that Subdirectory
CheckDownloadDirectory <- function(WorkingDirectory,SubDirectory){
  if(!dir.exists(file.path(WorkingDirectory, SubDirectory)))
  {
    dir.create(SubDirectory)  
    return("Subdirectory set")
  }
  else
  {
    return("Subdirectory already set")
  }
}

# Method set to auto to get it working on windows
DownloadFile <- function(URI,FileLocation)
{
  if (! file.exists(FileLocation)) 
  {
    download.file(URI, destfile = FileLocation, method = "auto")
    return("File Downloaded")
  }
  else
  {
    return("File Exist")
  }
  
}

# Try to unzip file, otherwise show error
unzipFile <- function(FileLocation)
{
  out <- tryCatch(
    {
      unzip (FileLocation, files = NULL, overwrite = TRUE, exdir = ".", unzip = "internal")
      return("Unzipped File")
    },
    error=function(cond) {
      message(cond)
      return("ERROR while unzipping see message: ")
    },
    warning=function(cond) {
      message(cond)
      
      return("WARNING while unzipping")
    }
  )    
  return(out)
}

# Create a filepath consructed from the vector (v1), in compbination with the  paste function it will combine the vectors automatically,
# in a correct URI path
FilePath_m <- function(v1,Dir,Dimension)
{
  return(file.path(Dir,paste(v1,paste(Dimension,paste(v1,"txt",sep="."), sep="_"),sep = "/")))
}

# Load the Data in a table (for each URI seperated)
# We use the header = False = default
LoadDataToTable <- function(Filename,Header=FALSE)  
{
  return(read.table(Filename,header=Header))
}

Run_Analysis()